import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import '../data.dart';

class AdminUsersManager extends ChangeNotifier {

  List<User> users = [];

  List<String> get names => users.map((e) => e.name).toList();

  void updateUser(UserManager userManager) {
    if (userManager.adminEnabled) {
      _listenToUsers();
    }
  }

  void _listenToUsers() {
    final faker = Faker();
    for (int i = 0; i < 100; i++) {
      users.add(User(name: faker.person.name(), email: faker.internet.email()));
    }
    users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    notifyListeners();
  }
}
