import 'package:flutter/material.dart';

enum Mode { light, dark }

class ThemeModel {
  final String name;
  final Mode themeMode;
  final List<Color> backgroundGradient;
  final Color borderColor;
  final Color backgroundColor;
  final Color tabBarColor;
  final Color tabBarSelectedItemColor;
  final Color tabBarUnselectedItemColor;
  final String backgroundImage;
  final Color textColor;
  // final TextStyle headerFont;
  // final TextStyle textFont;
  // final TextStyle captionFont;

  ThemeModel({
    required this.name,
    required this.themeMode,
    required this.backgroundGradient,
    required this.borderColor,
    required this.backgroundColor,
    required this.tabBarColor,
    required this.tabBarSelectedItemColor,
    required this.tabBarUnselectedItemColor,
    required this.backgroundImage,
    required this.textColor,
    // required this.headerFont,
    // required this.textFont,
    // required this.captionFont,
  });
}
