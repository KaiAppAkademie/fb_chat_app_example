import 'package:fb_chat_example/data/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier({required AuthRepository authRepository})
      : _authRepository = authRepository {
    _listenToAuthStateChanges();
  }

  void _listenToAuthStateChanges() {
    _authRepository.onAuthStateChanged.listen((user) {
      if (user != null) {
        _isUserLoggedIn = true;
        _currentUser = user;
      } else {
        _isUserLoggedIn = false;
        _currentUser = null;
      }
      notifyListeners();
    });
  }

  final AuthRepository _authRepository;

  bool _isUserLoggedIn = false;
  bool get isUserLoggedIn => _isUserLoggedIn;

  User? _currentUser;
  User? get currentUser => _currentUser;

  void loginUser(String email, String password) {
    // Add error handling!
    _authRepository.loginUser(email, password);
  }

  void logoutUser() {
    // Add error handling!
    _authRepository.logoutUser();
  }

  void signUp(String email, String password) {
    // Add error handling!
    _authRepository.signUp(email, password);
  }

  void resetPassword(String email) {
    // Add error handling!
    _authRepository.resetPassword(email);
  }
}
