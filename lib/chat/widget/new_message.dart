import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _msgController = TextEditingController();

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

 void _submitMessage() async {
  final enteredMessage = _msgController.text.trim();

  if (enteredMessage.isEmpty) {
    return;
  }

  _msgController.clear();

  final auth = FirebaseAuth.instance;
  final user = auth.currentUser;

  if (user == null) {
    // Handle the case where the user is null, maybe show an error message
    print(user);
    return;
  }

  final userCredentials =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

  // if (!userCredentials.exists) {
  //   // Handle the case where userCredentials doesn't exist, maybe show an error message
  //   return;
  // }

  await FirebaseFirestore.instance.collection("chat").add({
    "text": enteredMessage,
    "createdAt": FieldValue.serverTimestamp(),
    "userId": user.uid,
    "username": userCredentials.data()?['username'],
    "userImage": userCredentials.data()?['profilePic'],
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Message sent'),
      duration: Duration(seconds: 2),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _msgController,
              decoration: InputDecoration(
                hintText: "Enter a message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onSubmitted: (_) => _submitMessage(),
            ),
          ),
          IconButton(
            onPressed: _submitMessage,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
