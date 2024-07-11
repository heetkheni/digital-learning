import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';


class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  final String courseName;
  final String selectedField;
  final String lesson;
  final String price;
  final File image;

  ConfirmScreen({
    super.key,
    required this.videoFile,
    required this.videoPath,
    required this.courseName,
    required this.image,
    required this.lesson,
    required this.price,
    required this.selectedField
  });

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;

  Future<String> _uploadVideoToStorage(String videoPath) async {
    Reference reference = FirebaseStorage.instance
        .ref(widget.courseName)
        .child("videos");

    UploadTask uploadTask = reference.putFile(File(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

   Future<void> uploadData(String name, String selectedField, String lesson,
      String price, File image) async {
    CollectionReference courses =
        FirebaseFirestore.instance.collection('courses');
    var imgURL = await uploadPicToFirebaseStorage();

    var videoURl = await _uploadVideoToStorage(widget.videoPath);

    try {
      await courses.add({
        'name': name,
        'category': selectedField,
        'lessons': lesson,
        'imgUrl': imgURL,
        'price': price,
        'videoUrl':videoURl
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> uploadPicToFirebaseStorage() async {
    // ignore: unnecessary_null_comparison
    if (widget.image != null) {
      Reference storageReference = FirebaseStorage.instance
          .ref(widget.courseName.toString())
          .child("images");
      await storageReference.putFile(widget.image);
      String downloadURL = await storageReference.getDownloadURL();
      print('Video uploaded. Download URL: $downloadURL');
      return downloadURL;
    } else {
      return "";
    }
  }

  @override
  void initState() {

    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(false);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(
                  controller,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                       await uploadData(widget.courseName, widget.selectedField, widget.lesson, widget.price, widget.image);
                      },
                      child: Text("Upload!"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
