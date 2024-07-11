import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isPassword;
  final FormFieldValidator<String>? validator;

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:width * 0.03),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(),   
        ),
        validator: validator,
      ),
    );
  }
}