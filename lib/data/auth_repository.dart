import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  /// If a user is logged in or not.
  Stream<User?> get onAuthStateChanged;

  /// The logged in user, if any.
  User? get currentUser;

  /// Login
  Future<void> loginUser(String email, String password);

  /// Logout
  Future<void> logoutUser();

  /// SignUp
  Future<void> signUp(String email, String password);

  /// Reset Password
  Future<void> resetPassword(String email);

  // Future<dynamic> signInWithGoogle();

  // Future<bool> signOutFromGoogle();
}
