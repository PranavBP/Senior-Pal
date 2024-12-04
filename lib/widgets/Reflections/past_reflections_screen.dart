import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero_minds/widgets/Reflections/reflection_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../models/reflection.dart';
import '../../provider/theme_provider.dart';
import 'package:hero_minds/widgets/Reflections/reflection_list_view.dart';

class PastReflectionsScreen extends ConsumerWidget {
  const PastReflectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reflections = ref.watch(reflectionListProvider); // Reflection list
    final theme = ref.watch(themeNotifierProvider); // Access the theme

    // Group reflections by date
    final Map<String, List<Reflection>> groupedReflections = {};
    for (var reflection in reflections) {
      final formattedDate =
          DateFormat('MMMM d, yyyy').format(reflection.createdAt);
      groupedReflections.putIfAbsent(formattedDate, () => []).add(reflection);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Past Reflections",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black, // Static black text color
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: theme.backgroundGradient, // Dynamic gradient
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        backgroundColor: theme.backgroundColor, // Dynamic background color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                theme.backgroundGradient, // Dynamic page background gradient
          ),
        ),
        child: reflections.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/empty_state.json',
                      width: 200,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "No reflections available.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Static black text color
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to add a new reflection screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.backgroundColor,
                        foregroundColor:
                            Colors.black, // Black button text color
                      ),
                      child: const Text("Add Your First Reflection"),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: groupedReflections.keys.length,
                itemBuilder: (context, index) {
                  final date = groupedReflections.keys.toList()[index];
                  final reflectionsForDate = groupedReflections[date]!;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            date,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Static black text color
                            ),
                          ),
                        ),
                        ...reflectionsForDate.map((reflection) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: theme.cardColor, // Dynamic card background
                            child: ListTile(
                              title: Text(
                                reflection.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color:
                                      Colors.black, // Static black text color
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reflection.content,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors
                                          .black, // Static black text color
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        "Mood: ${reflection.mood ?? 'N/A'}",
                                        style: const TextStyle(
                                          color: Colors
                                              .black, // Static black text color
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Words: ${reflection.content.split(' ').length}",
                                        style: const TextStyle(
                                          color: Colors
                                              .black, // Static black text color
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward,
                                color: Colors.black, // Static black icon color
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ReflectionDetailsScreen(
                                            reflection: reflection),
                                  ),
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
