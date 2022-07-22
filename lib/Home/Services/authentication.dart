// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../Presentation/Sacaffold.dart';
import 'model.dart';
import 'package:hive/hive.dart';

class AuthenticationService {
  static late Box<User> _user;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    // await _user.clear();

    _user = await Hive.openBox<User>('usersBox');
  }

  Future<LoginResult> authenticateRecovery(
      String username, String recovery) async {
    final success = _user.values.any((element) =>
        element.username == username && element.recover == recovery);
    if (success) {
      return LoginResult.success;
    } else {
      return LoginResult.failure;
    }
  }

  static String GetPassword(String username) {
    final result =
        _user.values.where((element) => element.username == username);
    print(result);
    if (result == false) {
      var id = result.first;
      return id.password;
    } else {
      return "";
      
    }
  }

  Future<String?> authenticateUser(String username, String password) async {
    final success = _user.values.any((element) =>
        element.username == username && element.password == password);
    if (success) {
      return username;
    } else {
      return null;
    }
  }

  Future<userAccountCreationResult> createUser(
      final String username,
      final String password,
      final String recovery,
      BuildContext context) async {
    final user = _user.values.any(
        (element) => element.username.toLowerCase() == username.toLowerCase());

    if (user) {
      return userAccountCreationResult.already_exists;
    }
    try {
      _user
          .add(User(username: username, password: password, recover: recovery));
      ShowScaffold(context, "Logged In as " + username);
      return userAccountCreationResult.success;
    } on Exception catch (_) {
      return userAccountCreationResult.failure;
    }
  }
}

enum userAccountCreationResult {
  already_exists,
  success,
  failure,
}
enum LoginResult {
  success,
  failure,
}
