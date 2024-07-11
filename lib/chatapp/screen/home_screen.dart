import 'package:flutter/material.dart';
import 'package:tutorhub/chatapp/widget/user_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF553370),
        title: Text(
          "Chat Up",
          style: TextStyle(
              color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Color(0xFF3a2144),
                          borderRadius: BorderRadius.circular(15)),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
        ],
      ),
      body: SingleChildScrollView(
        child: 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:13.0),
                child: Column(
                  children: [
                    UserTile(),
                    
                    UserTile()
                  ],
                ),
              ),
            
          ),
        
      
    );
  }
}
