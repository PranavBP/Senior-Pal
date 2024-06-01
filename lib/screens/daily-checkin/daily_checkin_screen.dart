import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seniorpal/data/questions.dart';
import 'package:seniorpal/provider/theme_provider.dart';
import 'package:seniorpal/screens/daily-checkin/summary_screen.dart';
import 'package:seniorpal/widgets/Common/custom_app_bar.dart';
import 'package:seniorpal/widgets/Common/gradient_layer.dart';

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
            // mainAxisAlignment: MainAxisAlignment.center,
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  questions[currentQuestionIndex].title,
                  style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              ...questions[currentQuestionIndex].options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
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
        ],
      ),
    );
  }
}
