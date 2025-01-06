import 'dart:io'; // For handling files
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart'; // For picking images
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For Firebase Storage
import 'package:hero_minds/managers/auth_manager.dart';
import 'package:hero_minds/provider/theme_provider.dart';
import 'package:hero_minds/widgets/Common/custom_app_bar.dart';
import 'package:hero_minds/widgets/Common/gradient_layer.dart';
import 'package:flutter/services.dart'; // For PlatformException
import 'package:hero_minds/models/user.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  File? _profileImage; // To store the selected image file
  final ImagePicker _picker = ImagePicker(); // Image picker instance
  bool _isUploading = false; // To track the upload process

  // Function to pick image from gallery with error handling
  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
        // Upload the image to Firebase Storage
        await _uploadProfileImage();
      } else {
        print('No image selected.');
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Function to upload the image to Firebase Storage and update photoURL
  Future<void> _uploadProfileImage() async {
    if (_profileImage == null) return;

    setState(() {
      _isUploading = true; // Show a loading indicator during upload
    });

    try {
      // Create a reference to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${user?.uid}.jpg');

      // Upload the file
      await storageRef.putFile(_profileImage!);

      // Get the download URL
      final downloadURL = await storageRef.getDownloadURL();

      // Update the Firebase user's photoURL
      await user?.updatePhotoURL(downloadURL);
      await user?.reload(); // Reload the user to reflect changes

      setState(() {
        _profileImage = null; // Clear the local image file after upload
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture updated successfully!')),
      );
    } catch (e) {
      print('Error uploading profile image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile picture.')),
      );
    } finally {
      setState(() {
        _isUploading = false; // Stop the loading indicator
      });
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),

                // Profile Picture with Image Picker option
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : (user?.photoURL != null
                                ? NetworkImage(user!.photoURL!)
                                : const AssetImage(
                                        'assets/images/profile_pic.jpeg')
                                    as ImageProvider),
                      ),
                      if (_isUploading)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 0,
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
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // First Name, Last Name
                // Text(
                //   "Hello, ${user?.firstName ?? "User"}",
                //   style: TextStyle(
                //     color: currentTheme.textColor,
                //     fontSize: 16.0,
                //     fontWeight: FontWeight.normal,
                //   ),
                // ),
                Text(
                  "Hello, ${user?.displayName ?? "User"}",
                  style: TextStyle(
                    color: currentTheme.textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 8),

                // Email
                Text(
                  "Signed in as ${user?.email}",
                  style: TextStyle(
                    color: currentTheme.textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                const SizedBox(height: 16),

                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      // User Dummy Button
                      // ElevatedButton(
                      //   onPressed: () {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //           content: Text('User button clicked!')),
                      //     );
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: currentTheme.tabBarColor,
                      //     foregroundColor:
                      //         currentTheme.tabBarUnselectedItemColor,
                      //     minimumSize: const Size(double.infinity, 50),
                      //     padding: const EdgeInsets.symmetric(vertical: 15),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     textStyle: const TextStyle(
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      //   child: const Text("User"),
                      // ),

                      // const SizedBox(height: 12),

                      // // Daily Check-In Dummy Button
                      // ElevatedButton(
                      //   onPressed: () {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //           content:
                      //               Text('Daily Check-In button clicked!')),
                      //     );
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: currentTheme.tabBarColor,
                      //     foregroundColor:
                      //         currentTheme.tabBarUnselectedItemColor,
                      //     minimumSize: const Size(double.infinity, 50),
                      //     padding: const EdgeInsets.symmetric(vertical: 15),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     textStyle: const TextStyle(
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      //   child: const Text("Daily Check-In"),
                      // ),

                      // const SizedBox(height: 12),

                      // Sign Out Button
                      ElevatedButton(
                        onPressed: () {
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

// import 'dart:io'; // For handling files
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart'; // For picking images
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart'; // For Firebase Storage
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
// import 'package:hero_minds/managers/auth_manager.dart';
// import 'package:hero_minds/provider/theme_provider.dart';
// import 'package:hero_minds/widgets/Common/custom_app_bar.dart';
// import 'package:hero_minds/widgets/Common/gradient_layer.dart';
// import 'package:flutter/services.dart'; // For PlatformException
// import 'package:hero_minds/models/user.dart';

// class ProfilePage extends ConsumerStatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   ConsumerState<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends ConsumerState<ProfilePage> {
//   final user = FirebaseAuth.instance.currentUser;
//   File? _profileImage; // To store the selected image file
//   final ImagePicker _picker = ImagePicker(); // Image picker instance
//   bool _isUploading = false; // To track the upload process

//   // Store the user's first and last name from Firestore
//   String? firstName;
//   String? lastName;

//   // Function to pick image from gallery with error handling
//   Future<void> _pickImage() async {
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//       if (pickedFile != null) {
//         setState(() {
//           _profileImage = File(pickedFile.path);
//         });
//         // Upload the image to Firebase Storage
//         await _uploadProfileImage();
//       } else {
//         print('No image selected.');
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }

//   // Function to upload the image to Firebase Storage and update photoURL
//   Future<void> _uploadProfileImage() async {
//     if (_profileImage == null) return;

//     setState(() {
//       _isUploading = true; // Show a loading indicator during upload
//     });

//     try {
//       // Create a reference to Firebase Storage
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('profile_images/${user?.uid}.jpg');

//       // Upload the file
//       await storageRef.putFile(_profileImage!);

//       // Get the download URL
//       final downloadURL = await storageRef.getDownloadURL();

//       // Update the Firebase user's photoURL
//       await user?.updatePhotoURL(downloadURL);
//       await user?.reload(); // Reload the user to reflect changes

//       setState(() {
//         _profileImage = null; // Clear the local image file after upload
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Profile picture updated successfully!')),
//       );
//     } catch (e) {
//       print('Error uploading profile image: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to update profile picture.')),
//       );
//     } finally {
//       setState(() {
//         _isUploading = false; // Stop the loading indicator
//       });
//     }
//   }

//   // Fetch user data (first_name, last_name) from Firestore
//   Future<void> _getUserData() async {
//     if (user != null) {
//       try {
//         // Query Firestore to get the user's data
//         DocumentSnapshot doc = await FirebaseFirestore.instance
//             .collection(
//                 'users') // assuming your users are stored under the "users" collection
//             .doc(user!.uid)
//             .get();

//         if (doc.exists) {
//           setState(() {
//             firstName = doc['first_name'];
//             lastName = doc['last_name'];
//           });
//         }
//       } catch (e) {
//         print("Error fetching user data: $e");
//       }
//     }
//   }

//   // Sign out function
//   Future<void> _signOut() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).pop(); // Optionally navigate back to the login screen
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getUserData(); // Fetch user data when the page is initialized
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentTheme = ref.watch(themeNotifierProvider);

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image with gradient overlay
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.55,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(currentTheme.backgroundImage),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: Column(
//               children: [
//                 CustomAppBar(
//                   title: "Profile",
//                   icon: const Icon(
//                     Icons.close_rounded,
//                     color: Colors.white,
//                   ),
//                   backgroundColor: Colors.black.withOpacity(0.2),
//                   titleColor: Colors.white,
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 GradientLayer(colors: [
//                   Colors.black.withOpacity(0.2),
//                   ...currentTheme.backgroundGradient
//                 ])
//               ],
//             ),
//           ),
//           Positioned.fill(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.25,
//                 ),

//                 // Profile Picture with Image Picker option
//                 GestureDetector(
//                   onTap: _pickImage,
//                   child: Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: 50,
//                         backgroundImage: _profileImage != null
//                             ? FileImage(_profileImage!)
//                             : (user?.photoURL != null
//                                 ? NetworkImage(user!.photoURL!)
//                                 : const AssetImage(
//                                         'assets/images/profile_pic.jpeg')
//                                     as ImageProvider),
//                       ),
//                       if (_isUploading)
//                         Positioned.fill(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.5),
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Center(
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: CircleAvatar(
//                           backgroundColor: Colors.grey[300],
//                           radius: 16,
//                           child: const Icon(
//                             Icons.edit,
//                             size: 18,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 12),

//                 // Display First Name and Last Name
//                 Text(
//                   "Hello, ${firstName ?? 'User'} ${lastName ?? ''}",
//                   style: TextStyle(
//                     color: currentTheme.textColor,
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 // Email
//                 Text(
//                   "Signed in as ${user?.email}",
//                   style: TextStyle(
//                     color: currentTheme.textColor,
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 // Buttons (remain unchanged)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                   child: Column(
//                     children: [
//                       // User Dummy Button
//                       ElevatedButton(
//                         onPressed: () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text('User button clicked!')),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: currentTheme.tabBarColor,
//                           foregroundColor:
//                               currentTheme.tabBarUnselectedItemColor,
//                           minimumSize: const Size(double.infinity, 50),
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           textStyle: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         child: const Text("User"),
//                       ),

//                       const SizedBox(height: 12),

//                       // Daily Check-In Dummy Button
//                       ElevatedButton(
//                         onPressed: () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content:
//                                     Text('Daily Check-In button clicked!')),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: currentTheme.tabBarColor,
//                           foregroundColor:
//                               currentTheme.tabBarUnselectedItemColor,
//                           minimumSize: const Size(double.infinity, 50),
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           textStyle: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         child: const Text("Daily Check-In"),
//                       ),

//                       const SizedBox(height: 12),

//                       // Sign Out Button
//                       ElevatedButton(
//                         onPressed: _signOut,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                           foregroundColor: Colors.white,
//                           minimumSize: const Size(double.infinity, 50),
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           textStyle: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         child: const Text("Sign Out"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
