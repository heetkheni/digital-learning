// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

// class AddVideoScreen extends StatefulWidget {
//   const AddVideoScreen({super.key});

//   @override
//   State<AddVideoScreen> createState() => _AddVideoScreenState();
// }

// class _AddVideoScreenState extends State<AddVideoScreen> {


//   pickVideo(ImageSource src , BuildContext context) async{
//     final video = await ImagePicker().pickVideo(source: src);

//     if(video != null){
//       Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmScreen
//       (
//         videoFile: File(video.path),
//         videoPath: video.path,
//       )));
//     }
//   }





//   showOptionDialogue(BuildContext context){
//     return showDialog(context: context, builder: (context){
//       return SimpleDialog(
//         children: [
//           SimpleDialogOption(
//             onPressed: (){
//               pickVideo(ImageSource.gallery, context);
//             },
//             child: Row(
//               children: [
//                 Icon(Icons.photo),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Gallery",style: TextStyle(fontSize: 20),),
//                 )
//               ],
//             ),
//           ),
//           SimpleDialogOption(
//             onPressed: (){
//               pickVideo(ImageSource.camera, context);
//             },
//             child: Row(
//               children: [
//                 Icon(Icons.camera),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Camera",style: TextStyle(fontSize: 20),),
//                 )
//               ],
//             ),
//           ),
//           SimpleDialogOption(
//             onPressed: (){
//               Navigator.of(context).pop();
//             },
//             child: Row(
//               children: [
//                 Icon(Icons.close),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Close",style: TextStyle(fontSize: 20),),
//                 )
//               ],
//             ),
//           )
//         ],
//       );
//     });
//   }

  
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: InkWell(
//         onTap: (){
//           showOptionDialogue(context);
//         },
//         child: Container(
//           height: 50,
//           width: 200,
//           decoration: BoxDecoration(
//             //color: buttonColor
//           ),
//           child: Center(
//             child: Text("Add Video",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
//           ),
//         ),
//       )),
//     );
//   }
// }


// class ConfirmScreen extends StatefulWidget {
//   final File videoFile;
//   final String videoPath;
//   const ConfirmScreen(
//       {super.key, required this.videoFile, required this.videoPath});

//   @override
//   State<ConfirmScreen> createState() => _ConfirmScreenState();
// }

// class _ConfirmScreenState extends State<ConfirmScreen> {
//   late VideoPlayerController controller;

//     uploadVideo(String videoPath) async {

//     try {
      
     
//       String url = await _uploadVideoToStorage(videoPath);
//       // String thumbnail = await _uploadImagetoStorage("Video $len", videoPath);


//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future<String> _uploadVideoToStorage( String videoPath) async {
//     Reference reference = FirebaseStorage.instance.ref().child("videos").child(DateTime.now().microsecondsSinceEpoch.toString());

//     UploadTask uploadTask = reference.putFile(File(videoPath));
//     TaskSnapshot snap = await uploadTask;
//     String downloadUrl = await snap.ref.getDownloadURL();
//     return downloadUrl;
//   }

  
//   @override
//   void initState() {
//     // TODO: implement initState

//     super.initState();
//     setState(() {
//       controller = VideoPlayerController.file(widget.videoFile);
//     });
//     controller.initialize();
//     controller.play();
//     controller.setVolume(1);
//     controller.setLooping(false);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     controller.dispose();
//   }

//   final nameController = TextEditingController();
//   final captionController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 1.5,
//               child: VideoPlayer(controller,),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // Container(
//                   //   margin: EdgeInsets.symmetric(horizontal: 10),
//                   //   width: MediaQuery.of(context).size.width -20,
//                   //   child: TextInputField(controller: nameController, labelText: "Song Name", icon: Icons.music_note),
//                   // ),
//                   // const SizedBox(height: 10,),
//                   // Container(
//                   //   margin: EdgeInsets.symmetric(horizontal: 10),
//                   //   width: MediaQuery.of(context).size.width -20,
//                   //   child: TextInputField(controller: captionController, labelText: "Caption", icon: Icons.closed_caption),
//                   // ),
//                   //  const SizedBox(height: 10,),
//                    ElevatedButton(onPressed: (){
//                     _uploadVideoToStorage(widget.videoPath);
//                    }, child: Text("Upload!"))
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
