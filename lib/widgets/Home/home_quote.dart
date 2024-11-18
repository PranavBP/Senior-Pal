import 'package:flutter/material.dart';

class HomeQuote extends StatelessWidget {
  final String quote;

  const HomeQuote({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        quote,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
    );
  }
}
