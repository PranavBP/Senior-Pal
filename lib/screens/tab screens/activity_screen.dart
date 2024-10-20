import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hero_minds/provider/activity_provider.dart';
import 'package:hero_minds/provider/theme_provider.dart';
import 'package:hero_minds/widgets/Activity/activity_card.dart';

class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({super.key});

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);
    final activities = ref.watch(activityProvider);

    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Activity",
          style: TextStyle(
            color: currentTheme.textColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: currentTheme.backgroundColor,
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return ActivityCard(
            activity: activities[index],
            // onSelect: () {
            //   Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            //     return ModuleScreen(modules: activities[index].modules);
            //   }));
            // }
          );
        },
      ),
    );
  }
}
