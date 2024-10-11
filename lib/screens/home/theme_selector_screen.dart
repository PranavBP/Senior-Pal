import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seniorpal/data/themes.dart';
import 'package:seniorpal/models/theme.dart';
import 'package:seniorpal/provider/theme_provider.dart';
import 'package:seniorpal/widgets/Common/custom_app_bar.dart';
import 'package:seniorpal/widgets/Theme/theme_card.dart';

enum ThemeModeOption { light, dark }

class ThemeSelectorScreen extends ConsumerStatefulWidget {
  const ThemeSelectorScreen({super.key});

  @override
  ConsumerState<ThemeSelectorScreen> createState() =>
      _ThemeSelectorScreenState();
}

class _ThemeSelectorScreenState extends ConsumerState<ThemeSelectorScreen> {
  ThemeModeOption selectedThemeMode = ThemeModeOption.light;

  List<ThemeModel> getFilteredThemes() {
    if (selectedThemeMode == ThemeModeOption.light) {
      return themes.where((theme) => theme.themeMode == Mode.light).toList();
    } else {
      return themes.where((theme) => theme.themeMode == Mode.dark).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);
    final currentTheme = ref.watch(themeNotifierProvider);
    final filteredThemes = getFilteredThemes();

    return Scaffold(
        appBar: CustomAppBar(
            title: "Themes",
            icon: Icon(
              Icons.close_outlined,
              color: currentTheme.borderColor,
            ),
            backgroundColor: Colors.transparent,
            titleColor: currentTheme.textColor,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: currentTheme.backgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: SegmentedButton<ThemeModeOption>(
                style: SegmentedButton.styleFrom(
                  // backgroundColor: Colors.grey[200],
                  backgroundColor: currentTheme.backgroundColor,
                  foregroundColor: currentTheme.textColor,
                  selectedForegroundColor: currentTheme.tabBarSelectedItemColor,
                  selectedBackgroundColor: currentTheme.tabBarColor,
                  side: BorderSide(
                    color: currentTheme
                        .borderColor, // Set your desired border color
                    width: 1, // You can adjust the width as needed
                  ),
                ),
                segments: const <ButtonSegment<ThemeModeOption>>[
                  ButtonSegment<ThemeModeOption>(
                    value: ThemeModeOption.light,
                    label: Text('Light'),
                  ),
                  ButtonSegment<ThemeModeOption>(
                    value: ThemeModeOption.dark,
                    label: Text('Dark'),
                  ),
                ],
                selected: <ThemeModeOption>{selectedThemeMode},
                onSelectionChanged: (Set<ThemeModeOption> newSelection) {
                  setState(() {
                    selectedThemeMode = newSelection.first;
                  });
                },
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: GridView(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  children: [
                    for (final theme in filteredThemes)
                      ThemeCard(
                          theme: theme,
                          onSelect: () {
                            themeNotifier.updateTheme(theme);
                            Navigator.of(context).pop();
                          })
                  ],
                ),
              ),
            ),
          ],
        )
        // ListView.builder(
        //   itemCount: themes.length,
        //   itemBuilder: (context, index) {
        //     return ThemeCard(
        //       theme: themes[index],
        //       onSelect: () {
        //         themeNotifier.updateTheme(themes[index]);
        //         Navigator.of(context).pop();
        //       },
        //     );
        //   },
        // ),
        );
  }
}
