import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_minds/screens/login-registration/auth_screen.dart';
// import 'package:hero_minds/screens/home_screen.dart';
import 'package:hero_minds/screens/tab%20screens/tab_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const TabScreen();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
