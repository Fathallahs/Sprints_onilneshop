import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  // Very simple in-memory user store for demo purposes only
  final List<Map<String, String>> _users = [];

  bool get isAuthenticated => _isAuthenticated;

  Future<void> signUp(String fullName, String email, String password, {String? username}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final uname = (username != null && username.trim().isNotEmpty)
        ? username.trim()
        : email.split('@').first;
    _users.add({
      'fullName': fullName,
      'email': email,
      'username': uname,
      'password': password,
    });
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> signIn(String identifier, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final user = _users.firstWhere(
      (u) => (u['email'] == identifier || u['username'] == identifier) && u['password'] == password,
      orElse: () => {},
    );
    if (user.isNotEmpty) {
      _isAuthenticated = true;
      notifyListeners();
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<void> resetPassword({required String username, required String email, required String newPassword}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _users.indexWhere((u) => u['username'] == username && u['email'] == email);
    if (index >= 0) {
      _users[index]['password'] = newPassword;
    } else {
      throw Exception('User not found');
    }
  }
}
