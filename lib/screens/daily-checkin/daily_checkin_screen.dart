// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:hero_minds/data/questions.dart';
// import 'package:hero_minds/provider/theme_provider.dart';
// import 'package:hero_minds/screens/daily-checkin/summary_screen.dart';
// import 'package:hero_minds/widgets/Common/custom_app_bar.dart';
// import 'package:hero_minds/widgets/Common/gradient_layer.dart';

// class DailyCheckInScreen extends ConsumerStatefulWidget {
//   const DailyCheckInScreen({super.key});

//   @override
//   ConsumerState<DailyCheckInScreen> createState() {
//     return _DailyCheckInScreenState();
//   }
// }

// class _DailyCheckInScreenState extends ConsumerState<DailyCheckInScreen> {
//   int currentQuestionIndex = 0;
//   Map<int, String> userAnswers = {};

//   void nextQuestion(String answer) {
//     if (currentQuestionIndex == questions.length - 1) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SummaryScreen(userAnswers: userAnswers),
//         ),
//       );
//     } else {
//       setState(() {
//         userAnswers[currentQuestionIndex] = answer;
//         // if (currentQuestionIndex < questions.length - 1) {
//         currentQuestionIndex++;
//         // }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentTheme = ref.watch(themeNotifierProvider);

//     final screenWidth = MediaQuery.of(context).size.width;
//     final buttonWidth = screenWidth * 0.90; // 40% of screen width

//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Column(
//               children: [
//                 GradientLayer(colors: currentTheme.backgroundGradient)
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               CustomAppBar(
//                   title: "Daily Check-In",
//                   icon: Icon(
//                     Icons.close_rounded,
//                     color: currentTheme.textColor,
//                   ),
//                   backgroundColor: Colors.transparent,
//                   titleColor: currentTheme.textColor,
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   }),
//               Expanded(
//                 child: Scrollbar(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Text(
//                             questions[currentQuestionIndex].title,
//                             style: TextStyle(
//                                 fontSize: 24.0,
//                                 fontWeight: FontWeight.bold,
//                                 color: currentTheme.textColor),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         ...questions[currentQuestionIndex]
//                             .options
//                             .map((option) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16.0, vertical: 4.0),
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 minimumSize: Size(buttonWidth, 42),
//                                 backgroundColor: currentTheme.tabBarColor,
//                                 foregroundColor:
//                                     currentTheme.tabBarSelectedItemColor,
//                               ),
//                               onPressed: () => nextQuestion(option),
//                               child: Text(option),
//                             ),
//                           );
//                         }),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hero_minds/data/questions.dart';
import 'package:hero_minds/managers/daily_checkin_manager.dart';
import 'package:hero_minds/provider/theme_provider.dart';
import 'package:hero_minds/screens/daily-checkin/summary_screen.dart';
import 'package:hero_minds/widgets/Common/custom_app_bar.dart';
import 'package:hero_minds/widgets/Common/gradient_layer.dart';
import 'package:hero_minds/provider/auth_provider.dart';

class DailyCheckInScreen extends ConsumerStatefulWidget {
  const DailyCheckInScreen({super.key});

  @override
  ConsumerState<DailyCheckInScreen> createState() {
    return _DailyCheckInScreenState();
  }
}

class _DailyCheckInScreenState extends ConsumerState<DailyCheckInScreen> {
  int currentQuestionIndex = 0;
  Map<int, String> userAnswers = {};
  final DailyCheckInManager _checkInManager = DailyCheckInManager();

  void nextQuestion(String answer) async {
    // Dynamically get userId from the authProvider
    final userId = ref.read(authProvider).userId;
    if (userId == null) {
      // Handle missing userId (e.g., show an error or navigate to login)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated.')),
      );
      return;
    }
    
    final date = DateTime.now().toIso8601String().split('T').first; // e.g., "2024-12-21"

    setState(() {
      userAnswers[currentQuestionIndex] = answer;
    });

    if (currentQuestionIndex == questions.length - 1) {
      try {
        // Save answers to Firebase
        await _checkInManager.saveUserAnswers(userId, date, userAnswers);

        // Navigate to summary screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SummaryScreen(userAnswers: userAnswers),
          ),
        );
      } catch (e) {
        // Handle error (e.g., show a Snackbar or error dialog)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save data: $e')),
        );
      }
    } else {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.90; // 90% of screen width

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                GradientLayer(colors: currentTheme.backgroundGradient)
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(
                title: "Daily Check-In",
                icon: Icon(
                  Icons.close_rounded,
                  color: currentTheme.textColor,
                ),
                backgroundColor: Colors.transparent,
                titleColor: currentTheme.textColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            questions[currentQuestionIndex].title,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: currentTheme.textColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...questions[currentQuestionIndex].options.map((option) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 4.0,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(buttonWidth, 42),
                                backgroundColor: currentTheme.tabBarColor,
                                foregroundColor: currentTheme.tabBarSelectedItemColor,
                              ),
                              onPressed: () => nextQuestion(option),
                              child: Text(option),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

