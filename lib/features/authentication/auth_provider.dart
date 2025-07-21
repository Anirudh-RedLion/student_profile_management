import 'package:flutter/material.dart';
import 'auth_mock_data.dart';

class AuthProvider extends ChangeNotifier {
  MockUser? _currentUser;

  MockUser? get currentUser => _currentUser;
  UserRole? get currentRole => _currentUser?.role;
  bool get isLoggedIn => _currentUser != null;

  void login(MockUser user) {
    _currentUser = user;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
} 