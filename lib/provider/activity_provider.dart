import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seniorpal/models/activity.dart';

// Sample list of activities
final List<Activity> activities = [
  Activity(
    name: "Introduction",
    desc: "Get Started!",
    image: "assets/images/intro.jpg",
    completed: true,
  ),
  Activity(
    name: "Week 1",
    desc: "We're all Beginners",
    image: "assets/images/week1.jpg",
    completed: false,
  ),
  Activity(
    name: "Week 2",
    desc: "Shifting Perspective",
    image: "assets/images/week2.jpg",
    completed: false,
  ),
  Activity(
    name: "Week 3",
    desc: "Practice! Practice! Practice!",
    image: "assets/images/week3.jpg",
    completed: false,
  ),
  Activity(
    name: "Week 4",
    desc: "Let's talk about Stress",
    image: "assets/images/week4.jpg",
    completed: false,
  ),
];

// Riverpod provider for the activity list
final activityProvider = Provider<List<Activity>>((ref) {
  return activities;
});
