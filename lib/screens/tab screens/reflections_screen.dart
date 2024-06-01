import 'package:flutter/material.dart';

class ReflectionsScreen extends StatelessWidget {
  const ReflectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reflections"),
      ),
      body: const Center(
        child: Text("Reflections Screen"),
      ),
    );
  }
}