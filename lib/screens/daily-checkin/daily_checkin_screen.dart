import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hero_minds/data/questions.dart';
import 'package:hero_minds/provider/theme_provider.dart';
import 'package:hero_minds/screens/daily-checkin/summary_screen.dart';
import 'package:hero_minds/widgets/Common/custom_app_bar.dart';
import 'package:hero_minds/widgets/Common/gradient_layer.dart';

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

  void nextQuestion(String answer) {
    if (currentQuestionIndex == questions.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SummaryScreen(userAnswers: userAnswers),
        ),
      );
    } else {
      setState(() {
        userAnswers[currentQuestionIndex] = answer;
        // if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.90; // 40% of screen width

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
                  }),
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
                                color: currentTheme.textColor),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...questions[currentQuestionIndex]
                            .options
                            .map((option) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(buttonWidth, 42),
                                backgroundColor: currentTheme.tabBarColor,
                                foregroundColor:
                                    currentTheme.tabBarSelectedItemColor,
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
