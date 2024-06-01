import 'package:seniorpal/models/question.dart';

const List<Question> questions = [
  Question(
    title: "1. How are you feeling today?",
    options: [
      "Happy 😁",
      "Motivated 🤩",
      "Calm 🙂",
      "Blah 🫠",
      "Sad 😔",
      "Stressed 😖",
      "Angry 😡"
    ],
  ),
  Question(
    title: "2. I have been feeling stressed and nervous",
    options: ["Always", "Often", "Sometimes", "Rarely", "Never"],
  ),
  Question(
    title: "3. I have been satisfied with my sleep",
    options: ["Always", "Often", "Sometimes", "Rarely", "Never"],
  ),
  Question(
    title: "4. I have been engaging in activities I enjoy",
    options: ["Always", "Often", "Sometimes", "Rarely", "Never"],
  ),
  Question(
    title: "5. My social relationships have been supportive and rewarding",
    options: ["Always", "Often", "Sometimes", "Rarely", "Never"],
  ),
  Question(
    title: "6. Did you take your medication yesterday?",
    options: [
      "I don't take any medication",
      "I took all of my medication",
      "I didn't take any of my medication",
      "I took some of my medication"
    ],
  ),
];
