import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero_minds/provider/theme_provider.dart';

import 'package:hero_minds/widgets/Common/custom_app_bar.dart';

class SummaryScreen extends ConsumerWidget {
  final Map<int, String> userAnswers;

  const SummaryScreen({super.key, required this.userAnswers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);

    String suggestionText =
        'No suggestions at this moment, thank you for answering the daily check-In form. Have a great day!';

    for (var entry in userAnswers.entries) {
      int questionNumber = entry.key;
      String answerValue = entry.value;
      if ((questionNumber == 0 &&
              (answerValue == "Angry 😡" ||
                  answerValue == "Stressed 😖" ||
                  answerValue == "Sad 😔" ||
                  answerValue == "Blah 🫠")) ||
          (questionNumber == 1 &&
              (answerValue == "Sometimes" ||
                  answerValue == "Often" ||
                  answerValue == "Always")) ||
          (questionNumber == 2 &&
              (answerValue == "Rarely" ||
                  answerValue == "Sometimes" ||
                  answerValue == "Never")) ||
          (questionNumber == 3 &&
              (answerValue == "Rarely" ||
                  answerValue == "Sometimes" ||
                  answerValue == "Never")) ||
          (questionNumber == 4 &&
              (answerValue == "Rarely" ||
                  answerValue == "Sometimes" ||
                  answerValue == "Never"))) {
        suggestionText =
            'Based on all of your responses to the daily check-in questions, we recommend you visit the mindfulness tab to listen to different exercises that may provide strategies to manage your feelings, thoughts and stress.';
        break;
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: currentTheme.backgroundGradient,
              ),
            ),
          ),
          Column(
            children: [
              CustomAppBar(
                  title: "Suggestions",
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.transparent,
                  titleColor: currentTheme.textColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  suggestionText,
                  style:
                      TextStyle(fontSize: 18.0, color: currentTheme.textColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
