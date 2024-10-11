import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seniorpal/data/mindfulness_assets.dart';
import 'package:seniorpal/provider/theme_provider.dart';
import 'package:seniorpal/screens/tab%20screens/mindfulness/mindfulness_item.dart';

class MindfulnessScreen extends ConsumerStatefulWidget {
  const MindfulnessScreen({super.key});

  @override
  ConsumerState<MindfulnessScreen> createState() => _MindfulnessScreenState();
}

class _MindfulnessScreenState extends ConsumerState<MindfulnessScreen> {
  @override
  Widget build(BuildContext context) {
    // final theme = Provider.of<ThemeNotifier>(context).currentTheme;
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Mindfulness",
          style: TextStyle(
            color: theme.textColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.backgroundGradient[0],
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: theme.backgroundGradient,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              itemCount: mindfulnessItems.length,
              itemBuilder: (context, index) {
                return MindfulnessItem(
                  meditation: mindfulnessItems[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
