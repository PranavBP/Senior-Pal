import 'package:flutter/material.dart';

class Week1 extends StatelessWidget {
  const Week1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.justify,
              "Please take a few minutes to write a note to yourself as you begin this mindfulness program using the question below as a guide. This note is only for you so feel free to write as much or as little as you’d like. You will revisit this note at the end of the program.",
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "What do I want for myself from this program?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
