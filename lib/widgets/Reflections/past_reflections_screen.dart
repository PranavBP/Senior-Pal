// //-----old code-----//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import '../../models/reflection.dart';
// import '../../provider/theme_provider.dart';
// import 'reflection_details_screen.dart';
// import 'package:hero_minds/widgets/Reflections/reflection_list_view.dart';

// class PastReflectionsScreen extends ConsumerWidget {
//   const PastReflectionsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final reflections = ref.watch(reflectionListProvider);
//     final theme = ref.watch(themeNotifierProvider);

//     final Map<String, List<Reflection>> groupedReflections = {};
//     for (var reflection in reflections) {
//       final formattedDate =
//           DateFormat('MMMM d, yyyy').format(reflection.createdAt);
//       groupedReflections.putIfAbsent(formattedDate, () => []).add(reflection);
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           " ",
//           style: TextStyle(
//             color: theme.textColor,
//             fontSize: 32,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: theme.backgroundGradient[0],
//         elevation: 4,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: theme.backgroundGradient,
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: reflections.isEmpty
//                     ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.book_outlined,
//                               size: 120,
//                               color: theme.textColor.withOpacity(0.8),
//                             ),
//                             const SizedBox(height: 24),
//                             Text(
//                               "Your journey starts here!",
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: theme.textColor,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               "It looks like you don’t have any reflections yet. Start documenting your thoughts and track your progress over time.",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: theme.textColor.withOpacity(0.7),
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: 24),
//                             ElevatedButton(
//                               onPressed: () => Navigator.pop(context),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: theme.textColor,
//                                 foregroundColor: theme.backgroundColor,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 32, vertical: 12),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                               child: const Text(
//                                 "Add Your First Reflection",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     : ListView.builder(
//                         itemCount: groupedReflections.keys.length,
//                         itemBuilder: (context, index) {
//                           final date = groupedReflections.keys.toList()[index];
//                           final reflectionsForDate = groupedReflections[date]!;

//                           return Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 8.0, horizontal: 16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   date,
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: theme.textColor,
//                                   ),
//                                 ),
//                                 ...reflectionsForDate.map((reflection) {
//                                   return Card(
//                                     margin: const EdgeInsets.symmetric(
//                                         vertical: 8.0),
//                                     elevation: 4,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: theme
//                                             .boxColor, // Dynamically using the theme's boxColor
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: ListTile(
//                                         title: Text(
//                                           reflection.title,
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16,
//                                             color: theme.textColor,
//                                           ),
//                                         ),
//                                         subtitle: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               reflection.content,
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                 fontStyle: FontStyle.italic,
//                                                 color: theme.textColor
//                                                     .withOpacity(0.8),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   "Mood: ${reflection.mood ?? 'N/A'}",
//                                                   style: TextStyle(
//                                                     color: theme.textColor
//                                                         .withOpacity(0.7),
//                                                     fontSize: 12,
//                                                   ),
//                                                 ),
//                                                 const Spacer(),
//                                                 Text(
//                                                   "Words: ${reflection.content.split(' ').length}",
//                                                   style: TextStyle(
//                                                     color: theme.textColor
//                                                         .withOpacity(0.7),
//                                                     fontSize: 12,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         trailing: Icon(
//                                           Icons.arrow_forward,
//                                           color: theme.textColor,
//                                         ),
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ReflectionDetailsScreen(
//                                                       reflection: reflection),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//--------- fixed background theme with DB-------//
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/reflection.dart';
import '../../provider/theme_provider.dart';
import '../../controllers/reflection_controller.dart';
import 'reflection_details_screen.dart';

class PastReflectionsScreen extends ConsumerWidget {
  const PastReflectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reflectionController = ref.watch(reflectionControllerProvider);
    final reflections = reflectionController.reflections;
    final theme = ref.watch(themeNotifierProvider);

    final Map<String, List<Reflection>> groupedReflections = {};
    for (var reflection in reflections) {
      final formattedDate =
          DateFormat('MMMM d, yyyy').format(reflection.createdAt);
      groupedReflections.putIfAbsent(formattedDate, () => []).add(reflection);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Past Reflections",
          style: TextStyle(
            color: theme.textColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.backgroundGradient[0],
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: theme.backgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: reflections.isEmpty
              ? _buildEmptyState(theme, context)
              : _buildReflectionList(groupedReflections, theme, context),
        ),
      ),
    );
  }

  Widget _buildEmptyState(theme, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book_outlined,
            size: 120,
            color: theme.textColor.withOpacity(0.8),
          ),
          const SizedBox(height: 24),
          Text(
            "Your journey starts here!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "It looks like you don’t have any reflections yet. Start documenting your thoughts and track your progress over time.",
            style: TextStyle(
              fontSize: 16,
              color: theme.textColor.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.textColor,
              foregroundColor: theme.backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "Add Your First Reflection",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReflectionList(Map<String, List<Reflection>> groupedReflections,
      theme, BuildContext context) {
    return ListView.builder(
      itemCount: groupedReflections.keys.length,
      itemBuilder: (context, index) {
        final date = groupedReflections.keys.toList()[index];
        final reflectionsForDate = groupedReflections[date]!;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.textColor,
                ),
              ),
              ...reflectionsForDate.map((reflection) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.boxColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        reflection.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: theme.textColor,
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
                              color: theme.textColor.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                "Mood: ${reflection.mood ?? 'N/A'}",
                                style: TextStyle(
                                  color: theme.textColor.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "Words: ${reflection.content.split(' ').length}",
                                style: TextStyle(
                                  color: theme.textColor.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing:
                          Icon(Icons.arrow_forward, color: theme.textColor),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ReflectionDetailsScreen(reflection: reflection),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
