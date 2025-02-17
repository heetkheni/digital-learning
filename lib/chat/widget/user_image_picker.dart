
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePickerwidget extends StatefulWidget {
  const UserImagePickerwidget({super.key,required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePickerwidget> createState() => _UserImagePickerwidgetState();
}

class _UserImagePickerwidgetState extends State<UserImagePickerwidget> {

   File? _pickedImageFile;

    void _pickImage() async {
      ImagePicker imagePicker = ImagePicker();
     final pickedImage = await imagePicker.pickImage(source: ImageSource.camera , imageQuality:  50,maxWidth: 150);


     


     if(pickedImage != null){

      setState(() {
       _pickedImageFile = File(pickedImage.path);
     });
     }
     else {
      return;
     }

     widget.onPickImage(_pickedImageFile!);

    }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
           foregroundImage:_pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),
        TextButton.icon(onPressed: (){
          _pickImage();
        }, icon: Icon(Icons.image), label: Text("Add Image",style: TextStyle(
          color: Theme.of(context).primaryColor
        )))
      ],
    );
  }
  

}