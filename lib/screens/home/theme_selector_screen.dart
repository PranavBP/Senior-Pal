import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seniorpal/data/themes.dart';
import 'package:seniorpal/provider/theme_provider.dart';
import 'package:seniorpal/widgets/Common/custom_app_bar.dart';
import 'package:seniorpal/widgets/Theme/theme_card.dart';

class ThemeSelectorScreen extends ConsumerWidget {
  const ThemeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);
    final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: CustomAppBar(
          title: "Themes",
          icon: Icon(
            Icons.close_outlined,
            color: currentTheme.borderColor,
          ),
          backgroundColor: Colors.transparent,
          titleColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          }),
      backgroundColor: currentTheme.backgroundColor,
      body: ListView.builder(
        itemCount: themes.length,
        itemBuilder: (context, index) {
          return ThemeCard(
            theme: themes[index],
            onSelect: () {
              themeNotifier.updateTheme(themes[index]);
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}
