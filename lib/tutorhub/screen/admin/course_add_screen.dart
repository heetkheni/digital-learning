import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseAddScreen extends StatefulWidget {
  const CourseAddScreen({Key? key}) : super(key: key);

  @override
  _CourseAddScreenState createState() => _CourseAddScreenState();
}

class _CourseAddScreenState extends State<CourseAddScreen> {
  File? image;
  final picker = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController lessonController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  String categoryDropdownValue = 'Bedroom';
  String subcategoryDropdownValue = 'Single Bed';

  Map<String, List<String>> subcategories = {
    'Bedroom': ['Single Bed', 'Double Bed'],
    'Living Room': ['Single Seater Sofa', 'Double Seater Sofa', 'Three Seater Sofa', 'Recliner'],
    'Storage': ['Wardrobe', 'Bookshelf', 'Dressing Table'],
    'Kids': ['Kids Bed', 'Kids Seating', 'Kids Storage'],
    'Dining': ['Dining Chair', 'Dining Table'],
    'Study': ['Study Table', 'Office Table'],
  };

  List<String> categories = [
    'Bedroom',
    'Living Room',
    'Storage',
    'Kids',
    'Dining',
    'Study',
  ];

  Future<void> getImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print("No Image Picked");
      }
    });
  }

  Future<void> uploadCourse() async {
    try {
      // Upload image to Firebase Storage (optional, if you have an image)
      String imageUrl = "";
      if (image != null) {
        final firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('images')
            .child(DateTime.now().toString() + '.jpg');

        await ref.putFile(image!);
        imageUrl = await ref.getDownloadURL();
      }

      // Save course data to Firestore
      await FirebaseFirestore.instance.collection('courses').add({
        'name': nameController.text,
        'category': categoryDropdownValue,
        'subcategory': subcategoryDropdownValue,
        'imageUrl': imageUrl,
        'lessons': lessonController.text,
        'price': priceController.text,
        'qty': qtyController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Clear input fields after upload
      nameController.clear();
      lessonController.clear();
      priceController.clear();
      qtyController.clear();
      setState(() {
        categoryDropdownValue = 'Bedroom'; // Reset category dropdown
        subcategoryDropdownValue = 'Single Bed'; // Reset subcategory dropdown
        image = null; // Reset image selection
      });

      // Show success message or navigate to another screen
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Course uploaded successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error uploading course: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to upload course. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Course"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Product Name",
                hintText: "Enter Product name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: categoryDropdownValue,
              icon: Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  categoryDropdownValue = newValue!;
                  subcategoryDropdownValue = subcategories[newValue]![0]; // Set default subcategory
                });
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: subcategoryDropdownValue,
              icon: Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(
                labelText: "Subcategory",
                border: OutlineInputBorder(),
              ),
              items: subcategories[categoryDropdownValue]!.map((String subcategory) {
                return DropdownMenuItem<String>(
                  value: subcategory,
                  child: Text(subcategory),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  subcategoryDropdownValue = newValue!;
                });
              },
            ),
            SizedBox(height: 16.0),
            InkWell(
              onTap: () {
                getImage();
              },
              child: Container(
                height: height * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: image != null
                    ? Image.file(
                        image!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Icon(Icons.image, size: 50.0, color: Colors.grey),
                      ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: lessonController,
              decoration: InputDecoration(
                labelText: "Lessons",
                hintText: "Enter course lessons",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Price",
                hintText: "Enter product price",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Qty",
                hintText: "Enter Qty",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton.icon(
              onPressed: () {
                uploadCourse();
              },
              icon: Icon(Icons.upload),
              label: Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
