import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutorhub/tutorhub/screen/user/user_course_detail_screen.dart';

class Course {
  final String category;
  final String imgUrl;
  final String lessons;
  final String name;
  final String price;
  final String videoUrl;

  Course({
    required this.category,
    required this.imgUrl,
    required this.lessons,
    required this.name,
    required this.price,
    required this.videoUrl,
  });
}

class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Course List'),
          backgroundColor: Colors.blue,
        ),
        body: CourseList(),
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: fetchCoursesFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final course = snapshot.data![index];
              return CourseCard(course: course);
            },
          );
        }
      },
    );
  }

  Future<List<Course>> fetchCoursesFromFirestore() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('courses').get();

    return querySnapshot.docs.map((doc) {
      return Course(
        category: doc['category'],
        imgUrl: doc['imgUrl'],
        lessons: doc['lessons'],
        name: doc['name'],
        price: doc['price'],
        videoUrl: doc['videoUrl'],
      );
    }).toList();
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                course.imgUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Lessons: ${course.lessons}'),
                  SizedBox(height: 8),
                  Text('Price: \$${course.price}'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(course: course),
                  ),
                );
              },
              child: Text('Watch Video'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
