import 'dart:developer';

import 'package:fb_chat_example/data/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository extends AuthRepository {
  final authInstance = FirebaseAuth.instance;

  @override
  Stream<User?> get onAuthStateChanged => authInstance.authStateChanges();

  @override
  User? get currentUser => authInstance.currentUser;

  /// Login
  @override
  Future<void> loginUser(String email, String password) async {
    try {
      await authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  /// Logout
  @override
  Future<void> logoutUser() async {
    try {
      await authInstance.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  /// SignUp
  @override
  Future<void> signUp(String email, String password) async {
    try {
      await authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  /// Reset Password
  @override
  Future<void> resetPassword(String email) async {
    try {
      authInstance.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
    }
  }

  // Future<dynamic> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );

  //     return await authInstance.signInWithCredential(credential);
  //   } on Exception catch (e) {
  //     print('exception->$e');
  //   }
  // }

  // Future<bool> signOutFromGoogle() async {
  //   try {
  //     await GoogleSignIn().signOut();
  //     await authInstance.signOut();

  //     return true;
  //   } on Exception catch (_) {
  //     return false;
  //   }
  // }

  // User? getUser() {
  //   return authInstance.currentUser;
  // }
}
