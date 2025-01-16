import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:hero_minds/controllers/home_controller.dart';
import 'package:hero_minds/controllers/daily_checkin_controller.dart';
import 'package:hero_minds/provider/auth_provider.dart';

class HomePageController {
  final WidgetRef ref;
  final DailyCheckInController _dailyCheckInController;
  final UserController _userController = UserController();

  HomePageController(this.ref)
      : _dailyCheckInController = DailyCheckInController();

  // Fetch user data and daily quote
  Future<Map<String, String>> fetchUserData() async {
    try {
      final user = await _userController.fetchUserData();
      final quote = await _userController.fetchDailyQuote();

      return {
        'userFullName': user?.firstName ?? 'User',
        'dailyQuote': quote ?? 'No quote available today!',
      };
    } catch (e) {
      debugPrint("Error fetching data: $e");
      return {'userFullName': 'User', 'dailyQuote': 'Quote of the day!'};
    }
  }

  // Check if popup should be shown
  Future<bool> shouldShowPopup() async {
    try {
      final authNotifier = ref.read(authProvider.notifier);
      final userId = await authNotifier.initializeAuthState();

      final databaseRef = FirebaseDatabase.instance.ref();
      final snapshot =
          await databaseRef.child('users/$userId/last_seen_date').get();

      if (snapshot.exists) {
        final lastSeenDate = snapshot.value as String;
        final currentDate = DateFormat('MMMM d, yyyy').format(DateTime.now());

        debugPrint("Last seen date: $lastSeenDate");
        debugPrint("Current date: $currentDate");

        return lastSeenDate != currentDate;
      }
    } catch (e) {
      debugPrint("Error fetching last seen date: $e");
    }
    return true; // Show popup if no date is stored or it's a new day
  }

  // Update last seen date in database
  Future<void> updateLastSeenDate() async {
    try {
      final authNotifier = ref.read(authProvider.notifier);
      final userId = await authNotifier.initializeAuthState();

      final currentDate = DateFormat('MMMM d, yyyy').format(DateTime.now());
      final databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef
          .child('users/$userId/')
          .update({'last_seen_date': currentDate});

      debugPrint("Last seen date updated to: $currentDate");
    } catch (e) {
      debugPrint("Error updating last seen date: $e");
    }
  }

  // Handle daily check-in popup
  Future<void> handleDailyCheckInPopup(Function showDialogCallback) async {
    final authNotifier = ref.read(authProvider.notifier);
    final userId = await authNotifier.initializeAuthState();

    if (userId == null) {
      debugPrint("Error: User ID is null. Cannot proceed with daily check-in.");
      return;
    }

    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      final isCompleted = await _dailyCheckInController.isDailyCheckInCompleted(
          userId, currentDate);

      if (!isCompleted) {
        showDialogCallback();
      }
    } catch (error) {
      debugPrint("Error checking daily check-in status: $error");
    }
  }
}
