// controllers/user_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hero_minds/managers/database_manager.dart';
import 'package:hero_minds/managers/user_manager.dart';
import 'package:hero_minds/models/user.dart' as app_user;

class UserController {
  final DatabaseManager _databaseManager = DatabaseManager();

  Future<app_user.User?> fetchUserData() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      String uid = firebaseUser.uid;
      final user = await UserManager().getUser(uid);

      if (user != null) {
        return app_user.User(
            uid: uid,
            firstName: user.firstName,
            lastName: user.lastName,
            age: user.age,
            email: user.email);
      }
    }
    return null;
  }

  Future<String> fetchDailyQuote() async {
    String dayOfMonth = DateTime.now().day.toString();
    print(dayOfMonth);
    String? quote = await _databaseManager.fetchDailyQuote(dayOfMonth);
    return quote ??
        '“You may not control all the events that happen to you, but you can decide not to be reduced by them.” — Maya Angelou';
  }
}
