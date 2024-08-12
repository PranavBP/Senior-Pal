import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seniorpal/data/weekly_modules/week_1/week_1.dart';
import 'package:seniorpal/models/activity.dart';
import 'package:seniorpal/models/modules.dart';

// Sample list of activities
final List<Activity> activities = [
  Activity(
    name: "Introduction",
    desc: "Get Started!",
    image: "assets/images/intro.jpg",
    completed: true,
    modules: [
      const Module(
        title: "Welcome and Introduction",
        assetUrl:
            "assets/videos/intro1.mp4",
        isCompleted: true,
        isVideo: true,
      ),
      const Module(
        title: "What is Mindfulness?",
        assetUrl: "assets/videos/intro2.mp4",
        isCompleted: false,
        isVideo: false,
      ),
      const Module(
        title: "What should I expect?",
        assetUrl: "",
        isCompleted: false,
        isVideo: true,
      ),
      const Module(
        title: "What is stress?",
        assetUrl: "",
        isCompleted: false,
        isVideo: false,
      ),
    ],
    data: const Week1()
  ),
  Activity(
      name: "Week 1",
      desc: "We're all Beginners",
      image: "assets/images/week1.jpg",
      completed: false,
      modules: [],
      ),
  Activity(
      name: "Week 2",
      desc: "Shifting Perspective",
      image: "assets/images/week2.jpg",
      completed: false,
      modules: []),
  Activity(
      name: "Week 3",
      desc: "Practice! Practice! Practice!",
      image: "assets/images/week3.jpg",
      completed: false,
      modules: []),
  Activity(
      name: "Week 4",
      desc: "Let's talk about Stress",
      image: "assets/images/week4.jpg",
      completed: false,
      modules: []),
];

// Riverpod provider for the activity list
final activityProvider = Provider<List<Activity>>((ref) {
  return activities;
});
