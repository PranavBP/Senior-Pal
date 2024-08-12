import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seniorpal/provider/theme_provider.dart';

import 'package:seniorpal/screens/daily-checkin/daily_checkin_screen.dart';
import 'package:seniorpal/screens/home/theme_selector_screen.dart';

class HomeButtons extends ConsumerWidget {
  const HomeButtons({super.key});

  void _openThemesOverlay(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (ctx) => const ThemeSelectorScreen(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.48; // 40% of screen width

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: currentTheme.tabBarColor,
              maximumSize: Size(buttonWidth, 42)
              // This changes the color of the text and icon
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DailyCheckInScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.check_circle_outline,
            color: currentTheme.tabBarUnselectedItemColor,
          ),
          label: Text(
            'Daily Check-In',
            style: TextStyle(color: currentTheme.tabBarUnselectedItemColor),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: currentTheme.tabBarColor,
              maximumSize: Size(buttonWidth, 42)),
          onPressed: () {
            _openThemesOverlay(context);
          },
          icon: Icon(
            Icons.color_lens,
            color: currentTheme.tabBarUnselectedItemColor,
          ),
          label: Text(
            'Choose Theme',
            style: TextStyle(color: currentTheme.tabBarUnselectedItemColor),
          ),
        ),
      ],
    );
  }
}
