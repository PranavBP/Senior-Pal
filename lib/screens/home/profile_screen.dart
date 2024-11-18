import 'dart:io'; // For handling files
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart'; // For picking images
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hero_minds/managers/auth_manager.dart';
import 'package:hero_minds/provider/theme_provider.dart';
import 'package:hero_minds/widgets/Common/custom_app_bar.dart';
import 'package:hero_minds/widgets/Common/gradient_layer.dart';
import 'package:flutter/services.dart'; // For PlatformException

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  File? _profileImage; // To store the selected image file
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  // Function to pick image from gallery with error handling
  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      } else {
        // Handle case where user cancels image picking
        print('No image selected.');
      }
    } on PlatformException catch (e) {
      // Catch platform-specific exceptions (like permission denial)
      print('Failed to pick image: $e');
      // You can show a dialog or a Snackbar to notify the user
    } catch (e) {
      // Generic error handler
      print('Error picking image: $e');
    }
  }

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
                // Spacing to push content lower
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),

                // Profile Picture with Image picker option
                GestureDetector(
                  onTap: _pickImage, // Trigger image picking on tap
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : (user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : const AssetImage('assets/images/profile_pic.jpeg')
                                as ImageProvider),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 16,
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // First Name, Last Name (displayName from Firebase- not working)
                // Displaying the first name with a fallback
                Text(
                  "Hello, ${user?.uid ?? "User"}", // If firstName is null, "User" is shown
                  style: TextStyle(
                    color: currentTheme.textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                const SizedBox(height: 8),

                // Displaying the email
                Text(
                  "Signed in as ${user?.email}",
                  style: TextStyle(
                    color: currentTheme.textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                // Buttons (User, Daily Checking, Sign Out)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      // User Button
                      ElevatedButton(
                        onPressed: () {
                          // Implement user-specific action here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: currentTheme.tabBarColor,
                          foregroundColor:
                              currentTheme.tabBarUnselectedItemColor,
                          minimumSize: const Size(double.infinity, 50),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text("User"),
                      ),

                      const SizedBox(height: 12),

                      // Daily Checking Button
                      ElevatedButton(
                        onPressed: () {
                          // Implement daily checking functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: currentTheme.tabBarColor,
                          foregroundColor:
                              currentTheme.tabBarUnselectedItemColor,
                          minimumSize: const Size(double.infinity, 50),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text("Daily Checking"),
                      ),

                      const SizedBox(height: 12),

                      // Sign Out Button
                      ElevatedButton(
                        onPressed: () {
                          // Call AuthManager to sign out user
                          AuthManager().signOutUser();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text("Sign Out"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
