import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero_minds/models/activity.dart';

import 'package:hero_minds/provider/theme_provider.dart';
import 'package:hero_minds/screens/tab%20screens/mindfulness_screen.dart';
import 'package:hero_minds/widgets/Common/youtube_player.dart';

class ModuleScreen extends ConsumerWidget {
  // final List<Module> modules;
  final Activity activity;

  const ModuleScreen({super.key, required this.activity});

  // Check if the URL is a YouTube video by looking for "youtube" or "youtu.be" in the URL
  bool isYouTubeUrl(String url) {
    return url.contains('youtube.com') || url.contains('youtu.be');
  }

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
          activity.modules.isNotEmpty
              ? Expanded(
                flex: 2,
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
                          title: Text(
                            module.title,
                            style: const TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
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
                            if (isYouTubeUrl(module.assetUrl)) {
                              // If it's a YouTube video, open the YouTubePlayerScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) {
                                    return YouTubePlayerScreen(
                                      videoUrl: module.assetUrl,
                                    );
                                  },
                                ),
                              );
                            } else {
                              // If it's not a YouTube video, open your existing VideoPlayerScreen
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
                            }
                          },
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(
                  height: 1,
                ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: activity.data ??
                  const Text(
                    "Sorry, New content will be added here soon. Stay Tuned for updates. Thank you :)",
                    textAlign: TextAlign.center,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
