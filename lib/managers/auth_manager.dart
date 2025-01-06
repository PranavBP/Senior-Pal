import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Get current user
  Future<User?> getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    return user;
  }

  // Register User
  Future<String?> registerUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (error.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return error.message;
      }
    } catch (error) {
      return error.toString();
    }
  }

  // Login User
  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        return 'Invalid credentials - Please check if email or password is correct';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOutUser() {
    return _firebaseAuth.signOut();
  }

  // Function to send password reset email
  Future<String?> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
