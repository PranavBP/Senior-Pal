import 'package:flutter/material.dart';

class GradientLayer extends StatelessWidget {
  final List<Color> colors;

  const GradientLayer({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
