import 'package:app_fluxolivrep/src/models/user.dart';
import 'package:flutter/material.dart';

class UserRegisterProvider with ChangeNotifier {
  final List<User> _users = [
    User(id: 1, name: 'Admin', email: 'admin@email.com', password: '12345678'),
    User(id: 2, name: 'João Silva', email: 'joao@email.com', password: '12345678'),
    User(id: 3, name: 'Maria Santos', email: 'maria@email.com', password: '12345678'),
  ];

  List<User> get users => [..._users];

  Future<void> registerUser(User user) async {
    try {
      final newId = _users.isEmpty ? 1 : _users.last.id! + 1;
      final newUser = User(
        id: newId,
        name: user.name,
        email: user.email,
        password: user.password,
      );
      _users.add(newUser);
      notifyListeners();
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> updateUser(User user) async {
    try {
      final index = _users.indexWhere((u) => u.id == user.id);
      if (index >= 0) {
        _users[index] = user;
        notifyListeners();
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      _users.removeWhere((user) => user.id == id);
      notifyListeners();
    } catch (error) {
      throw error.toString();
    }
  }
}
