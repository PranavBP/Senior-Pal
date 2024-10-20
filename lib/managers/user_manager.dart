import 'package:firebase_database/firebase_database.dart';
import 'package:hero_minds/models/user.dart';

class UserManager {
  final DatabaseReference _userRef =
      FirebaseDatabase.instance.ref().child('users');

  Future<void> addUser(String uid, User user) async {
    try {
      await _userRef.child(uid).set(user.toJson());
    } catch (e) {
      // Handle error appropriately, e.g., throw an exception or log the error.
    }
  }

  Future<User?> getUser(String uid) async {
    try {
      final DataSnapshot snapshot = await _userRef.child(uid).get();
      if (snapshot.exists) {
        final Map<String, dynamic> userData =
            Map<String, dynamic>.from(snapshot.value as Map);
        return User.fromJson(userData);
      }
    } catch (e) {
      // Handle error appropriately, e.g., throw an exception or log the error.
    }
    return null;
  }
}
