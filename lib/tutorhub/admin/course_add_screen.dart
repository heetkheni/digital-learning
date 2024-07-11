import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutorhub/tutorhub/const/list.dart';
import 'package:tutorhub/tutorhub/screen/admin/confirm_screen.dart';
import 'package:tutorhub/tutorhub/utils/colors.dart';
import 'package:tutorhub/tutorhub/widget/custom_textfield.dart';
import 'package:video_player/video_player.dart';

class CourseAddScreen extends StatefulWidget {
  const CourseAddScreen({super.key});

  @override
  State<CourseAddScreen> createState() => _CourseAddScreenState();
}

class _CourseAddScreenState extends State<CourseAddScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lessonController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  XFile? video;
  final picker = ImagePicker();
  String dropdownvalue = 'Web Development';
  late VideoPlayerController videoPlayerController;

  File? image;

  pickVideo(ImageSource src, BuildContext context) async {
    video = await ImagePicker().pickVideo(source: src);

     if (video != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ConfirmScreen(
                              videoFile: File(video!.path),
                              videoPath: video!.path,
                              courseName: nameController.text.toString(),
                              image: image!,
                              lesson: lessonController.text.toString(),
                              price: priceController.text.toString(),
                              selectedField: dropdownvalue,
                            )));
                  }
  }

  showOptionDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () {
                  pickVideo(ImageSource.gallery, context);
                },
                child: Row(
                  children: [
                    Icon(Icons.photo),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Gallery",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  pickVideo(ImageSource.camera, context);
                },
                child: Row(
                  children: [
                    Icon(Icons.camera),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Camera",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    Icon(Icons.close),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Close",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  Future<void> getImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print("No Image Picked");
      }
    });
  }

  

 

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColors.white),
        title: Text(
          "Add Course",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            CustomTextField(
                controller: nameController,
                labelText: "Course Name",
                hintText: "Name"),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black26)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: DropdownButton(
                      menuMaxHeight: double.infinity,
                      isExpanded: true,
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(items),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.001,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: width * 0.025),
              child: InkWell(
                onTap: getImage,
                child: Container(
                  height: height * 0.3,
                  width: width * 0.94,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5)),
                  child: image != null
                      ? Image.file(
                          image!.absolute,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.image),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.001,
            ),
            CustomTextField(
                controller: lessonController,
                labelText: "Lessons",
                hintText: "Course Lessons"),
            SizedBox(
              height: height * 0.02,
            ),
            CustomTextField(
                controller: priceController,
                labelText: "Price",
                hintText: "Course Price"),
            SizedBox(
              height: height * 0.02,
            ),

            video != null ?
            InkWell(
              onTap: () {
                showOptionDialogue(context);
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    //color: buttonColor
                    ),
                child: Center(
                  child: Text(
                    "Add Video",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ) : SizedBox(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height / 1.5,
              // child: AspectRatio(
              //   aspectRatio: videoPlayerController.value.aspectRatio,
              //   child: VideoPlayer(
              //     videoPlayerController,
              //   ),
              // ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            ElevatedButton.icon(
                onPressed: () async {
                 pickVideo(ImageSource.gallery, context);
                },
                icon: Icon(Icons.upload),
                label: Text("Upload"))
          ],
        ),
      ),
    );
  }

 
}
