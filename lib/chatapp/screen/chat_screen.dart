import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorhub/chat/widget/chat_messages.dart';
import 'package:tutorhub/chat/widget/new_message.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final auth = FirebaseAuth.instance;

  void setupPushNotification() async {
    // Add code for setting up push notifications
  }

  void _logOut() async {
    await auth.signOut();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    setupPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
        actions: [
          IconButton(
            onPressed: () {
              _logOut();
            },
            icon: Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ChatMessages()),
          NewMessage(),
        ],
      ),
    );
  }
}
