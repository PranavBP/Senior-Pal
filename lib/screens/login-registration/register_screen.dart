import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hero_minds/managers/auth_manager.dart';
import 'package:hero_minds/managers/user_manager.dart';
import 'package:hero_minds/models/user.dart';
import 'package:hero_minds/widgets/Auth/auth_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.showLoginPage});

  final VoidCallback showLoginPage;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text Controllers - EMAIL & PASSWORD
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
  }

  void insertUser(String uid, User user) {
    UserManager().addUser(uid, user);
  }

  @override
  Widget build(BuildContext context) {
    void showMessage(String? message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message ?? "Firebase Auth - Creating account"),
        ),
      );
    }

    bool passwordConfirmed() {
      if (_passwordController.text.trim() ==
          _confirmPasswordController.text.trim()) {
        return true;
      } else {
        showMessage("Please check if both passwords matches.");
        return false;
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.handshake,
                    size: 100,
                  ),
                  // Welcome Message

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Hello There!",
                    style: GoogleFonts.bebasNeue(fontSize: 52),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                          " Click here to Login",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  const Text(
                    "Register below with your details.",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20.0),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // First name and Last Name TextField

                  AuthTextField(
                      controller: _firstNameController,
                      hintText: "First Name",
                      isObscure: false),
                  const SizedBox(height: 10),
                  AuthTextField(
                      controller: _lastNameController,
                      hintText: "Last Name",
                      isObscure: false),
                  const SizedBox(
                    height: 10,
                  ),

                  // Age TextField
                  AuthTextField(
                      controller: _ageController,
                      hintText: "Age",
                      isObscure: false),
                  const SizedBox(
                    height: 10,
                  ),

                  // Email TextField
                  AuthTextField(
                      controller: _emailController,
                      hintText: "Email",
                      isObscure: false),

                  const SizedBox(
                    height: 10,
                  ),

                  // Password and ConfirmPasswordTextField
                  AuthTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      isObscure: true),

                  const SizedBox(height: 10),

                  AuthTextField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                      isObscure: true),

                  const SizedBox(height: 25),

                  // Register Button

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (passwordConfirmed()) {
                          final uid = await AuthManager().registerUser(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim());

                          insertUser(
                            uid ?? "user-identifier",
                            User(
                              uid: uid ?? "user-identifier",
                              firstName: _firstNameController.text.trim(),
                              lastName: _lastNameController.text.trim(),
                              age: int.parse(_ageController.text.trim()),
                              email: _emailController.text.trim(),
                            ),
                          );
                          showMessage("Succesfully registered new account");
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(16.0)),
                        child: const Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
