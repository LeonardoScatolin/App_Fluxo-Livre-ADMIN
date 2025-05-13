import 'package:app_fluxolivrep/src/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final List<User> _users = [];

  List<User> get users => [..._users];

  Future<List<User>> fetchUsers() async {
    return _users;
  }

  Future<void> addUser(User user) async {
    final newId = _users.isEmpty ? 1 : _users.last.id! + 1;
    final newUser = User(
      id: newId,
      name: user.name,
      email: user.email,
      password: user.password,
    );

    _users.add(newUser);
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index >= 0) {
      _users[index] = user;
      notifyListeners();
    }
  }

  Future<void> deleteUser(int id) async {
    _users.removeWhere((user) => user.id == id);
    notifyListeners();
  }
}