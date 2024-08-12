import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seniorpal/models/activity.dart';

import 'package:seniorpal/provider/theme_provider.dart';
import 'package:seniorpal/screens/tab%20screens/mindfulness_screen.dart';

class ModuleScreen extends ConsumerWidget {
  // final List<Module> modules;
  final Activity activity;

  const ModuleScreen({super.key, required this.activity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      // backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(
        title: const Text("Weekly Modules"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: activity.modules.length,
              itemBuilder: (context, index) {
                final module = activity.modules[index];
                return Card(
                  elevation: 5.0,
                  shadowColor: currentTheme.tabBarColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  child: ListTile(
                    // leading: Icon(
                    //   module.isCompleted
                    //       ? Icons.check_circle
                    //       : Icons.radio_button_unchecked,
                    //   color: Colors.purple,
                    // ),
                    title: Text(
                      module.title,
                      style: const TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      module.isVideo ? Icons.videocam : Icons.audiotrack,
                      color: Colors.purple,
                    ),
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 16.0),
                    onTap: () {
                      // Handle module click
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return VideoPlayerScreen(
                              videoUrl: module.assetUrl,
                              dataSource: DataSourceType.asset,
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          // Add your widget here below the ListView.builder
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: activity.data ?? const Text("Sorry, New contnet will be added here soon. Stay Tuned for updates. Thank you :)"),
          ))
        ],
      ),
    );
  }
}
