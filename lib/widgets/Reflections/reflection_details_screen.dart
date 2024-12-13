import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/reflection.dart';
import '../../provider/theme_provider.dart';

class ReflectionDetailsScreen extends ConsumerWidget {
  final Reflection reflection;

  const ReflectionDetailsScreen({super.key, required this.reflection});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider); // Access the theme

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: theme.backgroundGradient, // Unified page gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button and Header Title
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: theme.textColor),
                      onPressed: () =>
                          Navigator.of(context).pop(), // Back button action
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "Reflection Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.textColor, // Dynamic text color
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16), // Space below the header
                // Reflection Details Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16), // Softer corners
                      ),
                      color: theme.boxColor, // Using the theme's boxColor
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: theme.boxColor, // Theme-specific box color
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Center(
                              child: Text(
                                reflection.title,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: theme.textColor, // Dynamic text color
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Content
                            Text(
                              reflection.content,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: theme.textColor.withOpacity(
                                    0.9), // Dynamic text color with contrast
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Divider(
                              thickness: 1,
                              color: Colors.black12,
                            ),
                            const SizedBox(height: 20),
                            // Metadata: Mood
                            Row(
                              children: [
                                const Icon(
                                  Icons.sentiment_satisfied_alt,
                                  color: Colors.orangeAccent,
                                  size: 24,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Mood: ${reflection.mood ?? 'N/A'}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        theme.textColor, // Dynamic text color
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            // Metadata: Word Count
                            Row(
                              children: [
                                const Icon(
                                  Icons.text_snippet,
                                  color: Colors.greenAccent,
                                  size: 24,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Word Count: ${reflection.content.split(' ').length}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        theme.textColor, // Dynamic text color
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
