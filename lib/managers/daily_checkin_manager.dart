import 'package:firebase_database/firebase_database.dart';

class DailyCheckInManager {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<void> addDailyCheckIn(
      String userId, String date, Map<String, dynamic> checkInData) async {
    try {
      await _database
          .child('users/$userId/daily_checkin/$date')
          .set(checkInData);
    } catch (e) {
      throw Exception('Failed to add daily check-in: $e');
    }
  }

  Future<Map<String, dynamic>?> getDailyCheckIn(
      String userId, String date) async {
    try {
      final snapshot =
          await _database.child('users/$userId/daily_checkin/$date').get();
      if (snapshot.exists) {
        return Map<String, dynamic>.from(snapshot.value as Map);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch daily check-in: $e');
    }
  }

  Future<void> saveUserAnswers(
      String userId, String date, Map<int, String> userAnswers) async {
    try {
      // Convert userAnswers map to Firebase-friendly format
      final formattedAnswers =
          userAnswers.map((key, value) => MapEntry(key.toString(), value));

      await _database.child('users/$userId/daily_checkin/$date').set({
        'answers': formattedAnswers,
        'date': date,
      });
    } catch (e) {
      throw Exception('Failed to save daily check-in: $e');
    }
  }
}
