import 'package:flutter/material.dart';

class GreetingText extends StatelessWidget {
  final String userFullName;

  const GreetingText({super.key, required this.userFullName});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Good Morning, $userFullName",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
