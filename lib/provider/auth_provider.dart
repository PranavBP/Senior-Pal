import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero_minds/managers/auth_manager.dart';

// User State Model
class AuthUser {
  final String? userId;
  final bool isLoggedIn;

  AuthUser({this.userId, this.isLoggedIn = false});

  factory AuthUser.initial() => AuthUser(userId: null, isLoggedIn: false);
}

// StateNotifier for Auth State
class AuthNotifier extends StateNotifier<AuthUser> {
  final AuthManager authManager;

  AuthNotifier(this.authManager) : super(AuthUser.initial());

  // Login User
  Future<String?> loginUser(String email, String password) async {
    final userId = await authManager.loginUser(email: email, password: password);
    if (userId != null) {
      state = AuthUser(userId: userId, isLoggedIn: true);
    }
    return userId;
  }

  // Logout User
  Future<void> logoutUser() async {
    await authManager.signOutUser();
    state = AuthUser.initial();
  }
}

// Riverpod Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthUser>(
  (ref) => AuthNotifier(AuthManager()),
);
