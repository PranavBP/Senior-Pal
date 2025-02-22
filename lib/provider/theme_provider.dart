import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seniorpal/data/themes.dart';
import 'package:seniorpal/models/theme.dart';

class ThemeNotifier extends StateNotifier<ThemeModel> {
  ThemeNotifier() : super(themes[1]); 

  void updateTheme(ThemeModel newTheme) {
    state = newTheme;
  }
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeModel>((ref) {
  return ThemeNotifier();
});
