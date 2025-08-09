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

  // Helper method to get a random student for testing
  MockUser getRandomStudent() {
    final students = mockUsers.where((user) => user.role == UserRole.student).toList();
    if (students.isEmpty) return mockUsers.first;
    students.shuffle();
    return students.first;
  }

  // Helper method to get all users of a specific role
  List<MockUser> getUsersByRole(UserRole role) {
    return mockUsers.where((user) => user.role == role).toList();
  }
} 