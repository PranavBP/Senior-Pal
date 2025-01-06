import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero_minds/managers/auth_manager.dart';
import 'package:hero_minds/managers/user_manager.dart';

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

// Initialize Auth State
  Future<String?> initializeAuthState() async {
    try {
      final currentUser = await authManager.getCurrentUser();
      if (currentUser != null) {
        debugPrint('Current user UID: ${currentUser.uid}');
        state = AuthUser(userId: currentUser.uid, isLoggedIn: true);
        return currentUser.uid; // Return userId
      } else {
        state = AuthUser.initial();
        return null; // Return null if no user is logged in
      }
    } catch (e) {
      state = AuthUser.initial(); // Reset state on failure
      return null; // Return null on failure
    }
  }

  // Login User
  Future<String?> loginUser(String email, String password) async {
    final userId =
        await authManager.loginUser(email: email, password: password);
    if (userId != null) {
      state = AuthUser(userId: userId, isLoggedIn: true);
    }
    return userId;
  }

  // Register User and update state
  Future<String?> registerUser(
      {required String email, required String password}) async {
    final uid =
        await authManager.registerUser(email: email, password: password);
    if (uid != null) {
      // Update state
      state = AuthUser(userId: uid, isLoggedIn: true);
    }
    return uid;
  }

  // Fetch User from Database
  Future<void> fetchUser(String userId) async {
    try {
      final user = await UserManager().getUser(userId);
      if (user != null) {
        state = AuthUser(userId: user.uid, isLoggedIn: true);
      }
    } catch (e) {
      state = AuthUser.initial(); // Reset state on failure
    }
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
