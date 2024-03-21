// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final double horizontal;
  final double vertical;
  final double radius;
  final TextInputType? keyboardType;

  const MyTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    required this.horizontal,
    required this.vertical,
    required this.radius,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(
              color: Color.fromARGB(0, 255, 255, 255),
            ),
          ),
          hintText: hint,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
