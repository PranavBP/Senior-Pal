import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero_minds/data/weekly_modules/week_1/week_1.dart';
import 'package:hero_minds/data/weekly_modules/week_4/week_4.dart';
import 'package:hero_minds/models/activity.dart';
import 'package:hero_minds/models/modules.dart';

// Sample list of activities
final List<Activity> activities = [
  Activity(
    name: "Week 1",
    desc: "Get Started!",
    image: "assets/images/intro.jpg",
    modules: [
      const Module(
        title: "Welcome and Introduction",
        assetUrl: "assets/videos/intro1.mp4",
        isCompleted: true,
        isVideo: true,
      ),
      const Module(
        title: "What is Mindfulness?",
        assetUrl: "assets/videos/intro2.mp4",
        isCompleted: false,
        isVideo: true,
      ),
      // const Module(
      //   title: "What should I expect?",
      //   assetUrl: "",
      //   isCompleted: false,
      //   isVideo: true,
      // ),
      const Module(
        title: "What is stress?",
        assetUrl: "https://www.youtube.com/watch?v=WuyPuH9ojCE",
        isCompleted: false,
        isVideo: true,
      ),
      const Module(
        title: "Neuroscience of Mindfulness Meditation",
        assetUrl: "https://www.youtube.com/watch?v=vo_VANW35b0",
        isCompleted: false,
        isVideo: true,
      ),
    ],
    data: const Week1()
  ),
  // Activity(
  //   name: "Week 2",
  //   desc: "We're all Beginners",
  //   image: "assets/images/week1.jpg",
  //   modules: [],
  // ),
  // Activity(
  //     name: "Week 3",
  //     desc: "Shifting Perspective",
  //     image: "assets/images/week2.jpg",
  //     modules: []),
  Activity(
    name: "Week 2",
    desc: "Practice! Practice! Practice!",
    image: "assets/images/week3.jpg",
    modules: [],
    data: const Week4(),
  ),
  // Activity(
  //   name: "Week 5",
  //   desc: "Let's talk about Stress",
  //   image: "assets/images/week4.jpg",
  //   modules: [],
  //   data: const DifficultCommunicationScreen(),
  // ),
];

// Riverpod provider for the activity list
final activityProvider = Provider<List<Activity>>((ref) {
  return activities;
});
