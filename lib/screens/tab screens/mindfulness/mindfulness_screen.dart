// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:hero_minds/data/mindfulness_assets.dart';
// import 'package:hero_minds/provider/theme_provider.dart';
// import 'package:hero_minds/screens/tab%20screens/mindfulness/mindfulness_item.dart';

// class MindfulnessScreen extends ConsumerStatefulWidget {
//   const MindfulnessScreen({super.key});

//   @override
//   ConsumerState<MindfulnessScreen> createState() => _MindfulnessScreenState();
// }

// class _MindfulnessScreenState extends ConsumerState<MindfulnessScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // final theme = Provider.of<ThemeNotifier>(context).currentTheme;
//     final theme = ref.watch(themeNotifierProvider);

//     return Scaffold(
//       backgroundColor: theme.backgroundColor,
//       appBar: AppBar(
//         title: Text(
//           "Mindfulness",
//           style: TextStyle(
//             color: theme.textColor,
//             fontSize: 32,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: theme.backgroundGradient[0],
//         centerTitle: false,
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: theme.backgroundGradient,
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: ListView.builder(
//               itemCount: mindfulnessItems.length,
//               itemBuilder: (context, index) {
//                 return MindfulnessItem(
//                   meditation: mindfulnessItems[index],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hero_minds/data/mindfulness_assets.dart';
import 'package:hero_minds/models/meditation_model.dart';
import 'package:hero_minds/provider/theme_provider.dart';
import 'package:hero_minds/screens/tab%20screens/mindfulness/mindfulness_item.dart';

class MindfulnessScreen extends ConsumerStatefulWidget {
  const MindfulnessScreen({super.key});

  @override
  ConsumerState<MindfulnessScreen> createState() => _MindfulnessScreenState();
}

class _MindfulnessScreenState extends ConsumerState<MindfulnessScreen> {
  final Map<String, bool> categoryVisibility = {}; // Track visibility state

  @override
  void initState() {
    super.initState();
    // Initialize visibility for each category
    mindfulnessItems.map((e) => e.category).toSet().forEach((category) {
      categoryVisibility[category] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);

    final itemsByCategory =
        mindfulnessItems.fold<Map<String, List<Meditation>>>(
      {},
      (map, item) {
        map.putIfAbsent(item.category, () => []).add(item);
        return map;
      },
    );

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
          ListView.builder(
            itemCount: itemsByCategory.keys.length,
            itemBuilder: (context, index) {
              final category = itemsByCategory.keys.elementAt(index);
              final items = itemsByCategory[category]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      category,
                      style: TextStyle(
                        color: theme.textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        categoryVisibility[category]!
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: theme.textColor,
                      ),
                      onPressed: () {
                        setState(() {
                          categoryVisibility[category] =
                              !categoryVisibility[category]!;
                        });
                      },
                    ),
                  ),
                  if (categoryVisibility[category]!)
                    ...items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: MindfulnessItem(meditation: item),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
