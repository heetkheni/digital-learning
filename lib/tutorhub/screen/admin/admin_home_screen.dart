import 'package:flutter/material.dart';
import 'package:tutorhub/tutorhub/screen/admin/course_add_screen.dart';
import 'package:tutorhub/tutorhub/utils/colors.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TutorHub",style: TextStyle(color:  AppColors.white),),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.analytics,color: AppColors.white))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.blue,onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseAddScreen()));
      },child: Icon(Icons.add,color: AppColors.white),),
    );
  }
}