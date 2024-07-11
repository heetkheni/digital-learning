// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:tutorhub/chat/widget/chat_messages.dart';
// import 'package:tutorhub/chat/widget/new_message.dart';

// class ChatScreen extends StatefulWidget {



//    ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final auth = FirebaseAuth.instance;


//   void setupPushNotification() async {
//         final firebaseMessaging = FirebaseMessaging.instance;
//       // final notificationSetting = await  firebaseMessaging.requestPermission();
//       await firebaseMessaging.requestPermission();
     
//   //  final token = await  firebaseMessaging.getToken();
//   //  print(token);
//    firebaseMessaging.subscribeToTopic('chat');

//   }

//   void _logOut(){
//     auth.signOut();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setupPushNotification();


//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Chat Screen"),
//         actions: [
//           IconButton(onPressed: (){
//             _logOut();
//           }, icon: Icon(Icons.logout_outlined))
//         ],
//       ),
//       body:Column(
//         children: [
//           Expanded(child: ChatMessages()),
//           NewMessage()
//         ],
//       )
//     );
//   }
// }