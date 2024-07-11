import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorhub/chat/widget/chat_bubble_widget.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key});

  @override
  Widget build(BuildContext context) {
    final authentication = FirebaseAuth.instance.currentUser;

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("chat")
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text("No Messages Found"),
          );
        }

        List<DocumentSnapshot<Map<String, dynamic>>> loadedMessages = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 13,
            right: 13,
          ),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessage = loadedMessages[index].data();
            final nextChatMessage = (index + 1 < loadedMessages.length)
                ? loadedMessages[index + 1].data()
                : null;

            final currentMessageUserId = chatMessage?['userId'];
            final nextMessageUserId = nextChatMessage?['userId'];
            final isMe = authentication?.uid == currentMessageUserId;

            if (currentMessageUserId != null) {
              if (nextMessageUserId != null && nextMessageUserId == currentMessageUserId) {
                return MessageBubble.next(
                  message: chatMessage?['text'],
                  isMe: isMe,
                );
              } else {
                return MessageBubble.first(
                  userImage: chatMessage?['userImage'] ?? getRandomProfileImage(), // Use a random profile image
                  username: chatMessage?['username'],
                  message: chatMessage?['text'],
                  isMe: isMe,
                );
              }
            }

            return SizedBox.shrink();
          },
        );
      },
    );
  }

  // Function to get a random profile image URL
  String getRandomProfileImage() {
   
  
    return "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=626&ext=jpg";
  }
}
