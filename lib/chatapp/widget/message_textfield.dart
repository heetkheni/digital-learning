import 'package:flutter/material.dart';

class SendMessageTextField extends StatelessWidget {
  const SendMessageTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      margin: EdgeInsets.only(top: 10,bottom: 15,left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[200], // Background color
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: true,
              cursorRadius: Radius.zero,
              style: TextStyle(fontSize: 16), // Adjust text font size
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                hintText: 'Type a message...',
                border: InputBorder.none, // Remove TextField border
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // _sendMessage();
            },
          ),
        ],
      ),
    );
  }
}

