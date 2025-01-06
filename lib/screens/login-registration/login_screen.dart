import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hero_minds/managers/auth_manager.dart';
import 'package:hero_minds/provider/auth_provider.dart';
import 'package:hero_minds/screens/login-registration/forgot_pw_screen.dart';
import 'package:hero_minds/widgets/Auth/auth_text_field.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key, required this.showReisterPage});

//   final VoidCallback showReisterPage;

//   @override
//   State<StatefulWidget> createState() {
//     return _LoginPageState();
//   }
// }

// class _LoginPageState extends State<LoginPage> {
//   // Text Controllers - EMAIL & PASSWORD
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   // Future signIn() async {
//   //   await FirebaseAuth.instance.signInWithEmailAndPassword(
//   //       email: _emailController.text.trim(),
//   //       password: _passwordController.text.trim());
//   // }

//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     void showMessage(String? message) {
//       ScaffoldMessenger.of(context).clearSnackBars();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           duration: const Duration(seconds: 3),
//           content: Text(message ?? "Firebase Auth Sign In"),
//         ),
//       );
//     }

//     void showAlert() {
//       // Check if email or password is empty

//       if (_emailController.text.trim().isEmpty ||
//           _passwordController.text.trim().isEmpty) {
//         showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: const Text('Invalid input'),
//             icon: const Icon(Icons.error),
//             content: const Text(
//                 'Please make sure a valid email and password was entered.'),
//             actions: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(ctx);
//                 },
//                 child: const Text('Okay'),
//               ),
//             ],
//           ),
//         );
//       }
//     }

//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.handshake,
//                   size: 100,
//                 ),
//                 // Welcome Message

//                 const SizedBox(
//                   height: 10,
//                 ),

//                 Text(
//                   "Hello again!",
//                   style: GoogleFonts.bebasNeue(fontSize: 52),
//                 ),

//                 const SizedBox(
//                   height: 10,
//                 ),

//                 const Text(
//                   " Welcome back, we missed you.",
//                   style:
//                       TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
//                 ),

//                 const SizedBox(
//                   height: 50,
//                 ),

//                 // Email TextField
//                 AuthTextField(
//                     controller: _emailController,
//                     hintText: "Email",
//                     isObscure: false),

//                 const SizedBox(height: 10),

//                 // Password TextField
//                 AuthTextField(
//                     controller: _passwordController,
//                     hintText: "Password",
//                     isObscure: true),

//                 const SizedBox(
//                   height: 10,
//                 ),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return const ForgotPasswordPage();
//                               },
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           "Forgot Password ?",
//                           style: TextStyle(
//                             color: Colors.deepOrange,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 10,
//                 ),

//                 // SignIn Button

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: GestureDetector(
//                     onTap: () async {
//                       if (_emailController.text.trim().isEmpty ||
//                           _passwordController.text.trim().isEmpty) {
//                         showAlert();
//                       } else {
//                         final message = await AuthManager().loginUser(
//                             email: _emailController.text.trim(),
//                             password: _passwordController.text.trim());

//                         showMessage(message);
//                       }
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                           color: Colors.deepPurple,
//                           borderRadius: BorderRadius.circular(16.0)),
//                       child: const Center(
//                         child: Text(
//                           "Sign In",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 25,
//                 ),

//                 // Register Button

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Not a Member?",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     GestureDetector(
//                       onTap: widget.showReisterPage,
//                       child: const Text(
//                         " Register Now",
//                         style: TextStyle(
//                             color: Colors.deepOrange,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key, required this.showRegisterPage});

  final VoidCallback showRegisterPage;

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void showMessage(String? message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message ?? "Firebase Auth Sign In"),
        ),
      );
    }

    void showAlert() {
      if (_emailController.text.trim().isEmpty ||
          _passwordController.text.trim().isEmpty) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Invalid input'),
            content: const Text(
                'Please make sure a valid email and password was entered.'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Okay'),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.handshake, size: 100),
                const SizedBox(height: 10),
                Text("Hello again!",
                    style: GoogleFonts.bebasNeue(fontSize: 52)),
                const SizedBox(height: 10),
                const Text("Welcome back, we missed you.",
                    style: TextStyle(fontSize: 20.0)),
                const SizedBox(height: 50),
                AuthTextField(
                  controller: _emailController,
                  hintText: "Email",
                  isObscure: false,
                ),
                const SizedBox(height: 10),
                AuthTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  isObscure: true,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage(),
                      ),
                    );
                  },
                  child: const Text("Forgot Password?",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0), // Adjust the value as needed
                  child: GestureDetector(
                    onTap: () async {
                      if (_emailController.text.trim().isEmpty ||
                          _passwordController.text.trim().isEmpty) {
                        showAlert();
                      } else {
                        final message =
                            await ref.read(authProvider.notifier).loginUser(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                        showMessage(message ?? "Login successful!");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: const Center(
                        child: Text("Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a Member?",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: const Text(" Register Now",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
