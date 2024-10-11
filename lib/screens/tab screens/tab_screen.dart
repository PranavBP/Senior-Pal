import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seniorpal/provider/theme_provider.dart';

import 'package:seniorpal/screens/tab%20screens/activity_screen.dart';
import 'package:seniorpal/screens/home/home_screen.dart';
import 'package:seniorpal/screens/tab%20screens/mindfulness/mindfulness_screen.dart';
import 'package:seniorpal/screens/tab%20screens/reflections_screen.dart';
import 'package:seniorpal/screens/tab%20screens/resources_screen.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;
  var _activePageTitle = "Home";

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      switch (index) {
        case 0:
          {
            _activePageTitle = 'Home';
          }
          break;
        // case 1:
        //   {
        //     _activePageTitle = 'Activity';
        //   }
        //   break;
        case 1:
          {
            _activePageTitle = 'Mindfulness';
          }
          break;
        case 2:
          {
            _activePageTitle = 'Resources';
          }
          break;
        case 3:
          {
            _activePageTitle = 'Reflections';
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);

    final List<Widget> pages = <Widget>[
      const HomePage(),
      // const ActivityScreen(),
      const MindfulnessScreen(),
      const ResourcesScreen(),
      const ReflectionsScreen()
    ];

    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      body: pages.elementAt(_selectedPageIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          child: BottomNavigationBar(
            selectedItemColor: currentTheme.tabBarSelectedItemColor,
            unselectedItemColor: currentTheme.tabBarUnselectedItemColor,
            type: BottomNavigationBarType.fixed,
            backgroundColor: currentTheme.tabBarColor,
            elevation: 0.0,
            onTap: _selectPage,
            currentIndex: _selectedPageIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.headset_rounded),
              //   label: "Activity",
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.self_improvement),
                label: 'Mindfulness',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: 'Resources',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit),
                label: 'Reflections',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
