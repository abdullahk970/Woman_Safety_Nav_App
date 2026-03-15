import 'package:flutter/material.dart';
import '../core/utils/json_loader.dart';
import '../models/user_model.dar.dart';


class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final List data = await JsonLoader.loadList('assets/json/users.json');
    final users = data.map((e) => UserModel.fromJson(e)).toList();

    await Future.delayed(const Duration(seconds: 1)); // UX delay

    final user = users.any(
          (u) => u.email == email && u.password == password,
    );

    if (user) {
      _isLoggedIn = true;
    } else {
      _errorMessage = "Invalid email or password";
    }

    _isLoading = false;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
