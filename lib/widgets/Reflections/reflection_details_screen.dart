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
      appBar: AppBar(
        title: Text(
          reflection.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black, // Static black text color
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: theme.backgroundGradient, // Dynamic gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.backgroundColor, // Dynamic background color
      ),
      body: Container(
        width: double.infinity, // Ensures full width
        height: double.infinity, // Ensures full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                theme.backgroundGradient, // Dynamic page background gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // Softer corners
              ),
              color: theme.cardColor, // Dynamic card background color
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Center(
                      child: Text(
                        reflection.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Black text for the title
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Content
                    Text(
                      reflection.content,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6, // Improved line height for readability
                        color: Colors.black, // Black text for the content
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
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Black text for metadata
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
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Black text for metadata
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
      ),
    );
  }
}
