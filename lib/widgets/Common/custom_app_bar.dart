// widgets/custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color titleColor;
  final Icon icon;
  final VoidCallback onPressed;

  const CustomAppBar(
      {super.key,
      required this.title,
      required this.icon,
      required this.backgroundColor,
      required this.titleColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [IconButton(onPressed: onPressed, iconSize: 32.0, icon: icon)],
      backgroundColor: backgroundColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
