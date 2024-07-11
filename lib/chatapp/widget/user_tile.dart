import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:13.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.network(
                "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Shivam Gupta",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "What are you doing?",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
