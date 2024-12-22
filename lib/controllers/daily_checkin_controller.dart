import 'package:hero_minds/managers/daily_checkin_manager.dart';

class DailyCheckInController {
  final DailyCheckInManager _manager = DailyCheckInManager();

  Future<void> addDailyCheckIn(String userId, String date, Map<String, dynamic> checkInData) async {
    await _manager.addDailyCheckIn(userId, date, checkInData);
  }

  Future<Map<String, dynamic>?> getDailyCheckIn(String userId, String date) async {
    return await _manager.getDailyCheckIn(userId, date);
  }
}
