import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero_minds/provider/theme_provider.dart';

class GreetingText extends ConsumerWidget {
  final String userFullName;

  const GreetingText({super.key, required this.userFullName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);

    return Text(
      "Good Morning, $userFullName",
      style: TextStyle(
        color: currentTheme.textColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
