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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book_outlined,
                        size: 120,
                        color: theme.textColor
                            .withOpacity(0.8), // Updated icon color
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Your journey starts here!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: theme.textColor, // Dynamic text color
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "It looks like you don’t have any reflections yet. Start documenting your thoughts and track your progress over time.",
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.textColor.withOpacity(
                              0.7), // Dynamic text color with opacity
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // Go back to the previous page
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              theme.textColor, // Updated button background
                          foregroundColor:
                              theme.backgroundColor, // Button text color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Add Your First Reflection",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: theme.textColor, // Dynamic text color
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
                            color: theme.cardColor.withOpacity(
                                0.9), // Adjust card background for contrast
                            child: ListTile(
                              title: Text(
                                reflection.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: theme.textColor, // Dynamic text color
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reflection.content,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: theme.textColor.withOpacity(
                                          0.8), // Dynamic text color with opacity
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        "Mood: ${reflection.mood ?? 'N/A'}",
                                        style: TextStyle(
                                          color: theme.textColor.withOpacity(
                                              0.7), // Dynamic text color with opacity
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Words: ${reflection.content.split(' ').length}",
                                        style: TextStyle(
                                          color: theme.textColor.withOpacity(
                                              0.7), // Dynamic text color with opacity
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Icon(
                                Icons.arrow_forward,
                                color: theme.textColor, // Dynamic icon color
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
