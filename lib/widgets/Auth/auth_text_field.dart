import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.isObscure});

  final TextEditingController controller;
  final String hintText;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromARGB(255, 238, 238, 238)),
                borderRadius: BorderRadius.circular(16.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(16.0)),
            hintText: hintText,
            fillColor: Colors.grey[200],
            filled: true),
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
