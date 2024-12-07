import 'package:flutter/material.dart';
import 'package:hero_minds/models/theme.dart';

final List<ThemeModel> themes = [
  ThemeModel(
    name: 'Patriot',
    themeMode: Mode.dark,
    backgroundGradient: [
      const Color(0xFF3D2821),
      const Color(0xFF1A110A),
    ],
    borderColor: Colors.white,
    backgroundColor: const Color(0xFF1A110A),
    tabBarColor: const Color(0xFFD7CEA3),
    tabBarSelectedItemColor: const Color(0xFF3D2821),
    tabBarUnselectedItemColor: const Color(0xFF1A110A),
    backgroundImage: 'assets/images/eagle.jpg',
    textColor: const Color(0xFFE6E6CC),
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Patriot',
    themeMode: Mode.light,
    backgroundGradient: [
      const Color(0xFF0A3061),
      const Color(0xFFB01A43),
    ],
    borderColor: Colors.white,
    backgroundColor: const Color(0xFFB01A43),
    tabBarColor: const Color(0xFF0A3061),
    tabBarSelectedItemColor: Colors.white,
    tabBarUnselectedItemColor: Colors.grey,
    textColor: Colors.white,
    backgroundImage: 'assets/images/flag.jpg',
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Fall',
    themeMode: Mode.dark,
    backgroundGradient: [
      const Color(0xFFE8B007),
      const Color(0xFF8A8210),
    ],
    borderColor: const Color(0xFFF8F2E6),
    backgroundColor: const Color(0xFF8A8210),
    tabBarColor: const Color(0xFF4D4A17),
    tabBarSelectedItemColor: const Color(0xFFF8F2E6),
    tabBarUnselectedItemColor: const Color.fromARGB(255, 184, 173, 22),
    textColor: const Color(0xFF4D4A17),
    backgroundImage: 'assets/images/fall2.jpg',
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Fall',
    themeMode: Mode.light,
    backgroundGradient: [
      const Color(0xFFE8AB42),
      const Color(0xFFE68724),
    ],
    borderColor: const Color(0xFF04565E),
    backgroundColor: const Color(0xFFE68724),
    tabBarColor: const Color(0xFF04565E),
    tabBarSelectedItemColor: const Color(0xFFE8B007),
    tabBarUnselectedItemColor: const Color(0xFFF7F7F7),
    backgroundImage: 'assets/images/fall.jpg',
    textColor: const Color(0xFFF7F7F7),
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Winter',
    themeMode: Mode.dark,
    backgroundGradient: [
      const Color(0xFF526D82),
      const Color(0xFF9EB2BF),
    ],
    borderColor: const Color(0xFF273743),
    backgroundColor: const Color(0xFF526D82),
    tabBarColor: const Color(0xFF273743),
    tabBarSelectedItemColor: Colors.white,
    tabBarUnselectedItemColor: const Color(0xFF9EB2BF),
    backgroundImage: 'assets/images/winter2.jpg',
    textColor: const Color(0xFFDEE6EE),
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Winter',
    themeMode: Mode.light,
    backgroundGradient: [
      const Color(0xFFA6D7E8),
      const Color(0xFF566CBA),
    ],
    borderColor: const Color(0xFF0A2447),
    backgroundColor: const Color(0xFF566CBA),
    tabBarColor: const Color(0xFF0A2447),
    tabBarSelectedItemColor: const Color(0xFFA6D7E8),
    tabBarUnselectedItemColor: Colors.grey,
    backgroundImage: 'assets/images/winter.jpg',
    textColor: const Color(0xFF0A2447),
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Spring',
    themeMode: Mode.dark,
    backgroundGradient: [
      // const Color(0xFFFFEDD0),
      const Color.fromARGB(255, 111, 41, 70),
      const Color(0xFF181716),
      // const Color(0xFFFFEDD0),
      // const Color(0xFFFFDFCC),
    ],
    borderColor: const Color(0xFFFFEDD0),
    backgroundColor: const Color(0xFF181716), //const Color(0xFFFFEDD0),
    tabBarColor: const Color.fromARGB(255, 251, 126, 159),
    tabBarSelectedItemColor: Colors.white,
    tabBarUnselectedItemColor: const Color(0xFFFFDFCC),
    backgroundImage: 'assets/images/spring2.jpg',
    textColor: const Color.fromARGB(255, 251, 126, 159),
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Spring',
    themeMode: Mode.light,
    backgroundGradient: [
      const Color(0xFFF2FDF1),
      const Color(0xFFFFE6E6),
    ],
    borderColor: const Color(0xFFFF99CC),
    backgroundColor: const Color(0xFFFFE6E6),
    tabBarColor: const Color.fromARGB(255, 153, 222, 123),
    tabBarSelectedItemColor: Colors.white,
    tabBarUnselectedItemColor: const Color(0xFFF2FDF1),
    backgroundImage: 'assets/images/spring.jpg',
    textColor: const Color(0xFFFF99CC),
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Summer',
    themeMode: Mode.dark,
    backgroundGradient: [
      const Color(0xFFE0E09E),
      const Color(0xFFF3B59F),
    ],
    borderColor: const Color(0xFFE0646B),
    backgroundColor: const Color(0xFFF3B59F),
    tabBarColor: const Color(0xFFBF5A83),
    tabBarSelectedItemColor: const Color(0xFFE0E09E),
    tabBarUnselectedItemColor: const Color(0xFFF3B59F),
    backgroundImage: 'assets/images/summer2.jpg',
    textColor: const Color(0xFFE0646B),
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Summer',
    themeMode: Mode.light,
    backgroundGradient: [
      const Color(
          0xFFB0DFC0), // Softer green to avoid overlap with the text color
      const Color(0xFF78E2EC), // Retained the light blue for a summer vibe
    ],
    borderColor: const Color(0xFF98B27F), // Keep the border color
    backgroundColor: const Color(
        0xFF78E2EC), // Use the second gradient color for consistency
    tabBarColor: const Color(0xFF6FCCA9), // Keep the same tab bar color
    tabBarSelectedItemColor:
        Colors.white, // White selected tab item for good contrast
    tabBarUnselectedItemColor: const Color.fromARGB(
        255, 232, 240, 224), // Light unselected tab item color
    backgroundImage: 'assets/images/summer.jpg', // Same background image
    textColor: const Color(
        0xFF4D4D4D), // Darker text color for better contrast against light backgrounds
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),

  // ThemeModel(
  //   name: 'Summer',
  //   themeMode: Mode.light,
  //   backgroundGradient: [
  //     const Color(0xFFD1F5C0),
  //     const Color(0xFF78E2EC),
  //   ],
  //   borderColor: const Color(0xFF98B27F),
  //   backgroundColor: const Color(0xFF78E2EC),
  //   tabBarColor: const Color(0xFF6FCCA9),
  //   tabBarSelectedItemColor: Colors.white,
  //   tabBarUnselectedItemColor: const Color(0xFFD8E4CC),
  //   backgroundImage: 'assets/images/summer.jpg',
  //   textColor: const Color(0xFFD8E4CC),
  // ),
  ThemeModel(
    name: 'Water',
    themeMode: Mode.dark,
    backgroundGradient: [
      const Color(0xFF2BC0E4), // Deep aquatic blue for a richer water feel
      const Color(0xFF2264A7), // Darker blue for depth
    ],
    borderColor: const Color(0xFF0A3D62), // Deep blue for contrast
    backgroundColor: const Color(
        0xFF2264A7), // Use the second gradient color for a consistent background
    tabBarColor: const Color(
        0xFF73D2F4), // Lighter blue for a fresh water-like appearance
    tabBarSelectedItemColor:
        Colors.white, // White for clear selection visibility
    tabBarUnselectedItemColor: const Color.fromARGB(
        255, 229, 246, 254), // Soft light blue for unselected tabs
    backgroundImage:
        'assets/images/water2.jpg', // Keep the water background image
    textColor: const Color(
        0xFFE0F7FA), // Very light aqua color to stand out against the darker blue background
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),

  // ThemeModel(
  //   name: 'Water',
  //   themeMode: Mode.dark,
  //   backgroundGradient: [
  //     const Color(0xFF3FFFFF),
  //     const Color(0xFF26A0FF),
  //   ],
  //   borderColor: const Color(0xFF0D3570),
  //   backgroundColor: const Color(0xFF26A0FF),
  //   tabBarColor: const Color(0xFFD6FFCF),
  //   tabBarSelectedItemColor: const Color(0xFF0D3570),
  //   tabBarUnselectedItemColor: const Color(0xFF26A0FF),
  //   backgroundImage: 'assets/images/water2.jpg',
  //   textColor: const Color(0xFFD6FFCF),
  // ),
  ThemeModel(
    name: 'Water',
    themeMode: Mode.light,
    backgroundGradient: [
      const Color(0xFFE19899),
      const Color(0xFFA36589),
    ],
    borderColor: const Color(0xFF421C38),
    backgroundColor: const Color(0xFFA36589),
    tabBarColor: const Color(0xFF421C38),
    tabBarSelectedItemColor: const Color(0xFFE19899),
    tabBarUnselectedItemColor: const Color(0xFFA36589),
    backgroundImage: 'assets/images/water.jpg',
    textColor: const Color(0xFF421C38),
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Fire',
    themeMode: Mode.dark,
    backgroundGradient: [
      const Color(0xFF2B4F4F),
      const Color(0xFF3D5050),
    ],
    borderColor: const Color(0xFFDBD6C9),
    backgroundColor: const Color(0xFF3D5050),
    tabBarColor: const Color(0xFFDBD6C9),
    tabBarSelectedItemColor: const Color(0xFF3D5050),
    tabBarUnselectedItemColor: const Color(0xFF6F5F46),
    backgroundImage: 'assets/images/fire2.jpg',
    textColor: const Color(0xFFDBD6C9),
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Fire',
    themeMode: Mode.light,
    backgroundGradient: [
      const Color(0xFF506B50),
      const Color(0xFF385149),
    ],
    borderColor: const Color(0xFFF0EC9D),
    backgroundColor: const Color(0xFF385149),
    tabBarColor: const Color(0xFFAC8C56),
    tabBarSelectedItemColor: Colors.white,
    tabBarUnselectedItemColor: const Color(0xFFF0EC9D),
    backgroundImage: 'assets/images/fire.jpg',
    textColor: const Color(0xFFF0EC9D),
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Animal',
    themeMode: Mode.dark,
    backgroundGradient: [
      const Color(0xFF262929),
      const Color(0xFF61667A),
    ],
    borderColor: const Color(0xFFD9D9D9),
    backgroundColor: const Color(0xFF61667A),
    tabBarColor: const Color(0xFFD9D9D9),
    tabBarSelectedItemColor: const Color(0xFF262929),
    tabBarUnselectedItemColor: const Color(0xFF61667A),
    backgroundImage: 'assets/images/animal.jpg',
    textColor: const Color(0xFFD9D9D9),
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
  ThemeModel(
    name: 'Animal',
    themeMode: Mode.light,
    backgroundGradient: [
      const Color(0xFFFBCFA4), // Lighter, warm yellow
      const Color(0xFFFFC070), // Slightly deeper orange
    ],
    borderColor: const Color(0xFF874A38), // Warm brown
    backgroundColor: const Color(0xFFFFC070), // Warm orange
    tabBarColor:
        const Color(0xFFD98E5B), // Rich caramel brown for better contrast
    tabBarSelectedItemColor: const Color(
        0xFFFFE3B3), // Light cream color to stand out against the tabBarColor
    tabBarUnselectedItemColor: const Color(
        0xFF874A38), // Darker brown for better contrast with tabBarColor
    backgroundImage: 'assets/images/animal2.jpg', // Animal-themed image
    textColor: const Color(
        0xFF4A3621), // Rich dark brown for readability and contrast against the lighter background
    iconColor: Colors.white,
    cardColor: Colors.black.withOpacity(0.5),
    appBarColor: Colors.grey,
  ),
];
