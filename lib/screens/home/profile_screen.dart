import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hero_minds/managers/auth_manager.dart';
import 'package:hero_minds/provider/theme_provider.dart';
import 'package:hero_minds/widgets/Common/custom_app_bar.dart';
import 'package:hero_minds/widgets/Common/gradient_layer.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Background image with gradient overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(currentTheme.backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                CustomAppBar(
                  title: "Profile",
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.black.withOpacity(0.2),
                  titleColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                GradientLayer(colors: [
                  Colors.black.withOpacity(0.2),
                  ...currentTheme.backgroundGradient
                ])
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                Text(
                  "Profile Page, Signed in as ${user?.email}",
                  style: TextStyle(
                      color: currentTheme.textColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal),
                ),

                const SizedBox(
                  height: 16,
                ),

                // Sign Out Button
                MaterialButton(
                  onPressed: () {
                    // FirebaseAuth.instance.signOut();
                    AuthManager().signOutUser();
                    Navigator.pop(context);
                  },
                  color: currentTheme.tabBarColor,
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                        color: currentTheme.tabBarUnselectedItemColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
          //
        ],
      ),
    );
  }
}
