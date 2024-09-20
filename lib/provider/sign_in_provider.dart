import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:machine_task_2/services/authentication.dart';
import 'package:machine_task_2/screens/driver/driver_home_page.dart';
import 'package:machine_task_2/screens/admin/home_page.dart';
import 'package:machine_task_2/utils/alerts_and_navigate.dart';

class SignInProvider extends ChangeNotifier {
  final AuthService _auth = AuthService();
  bool isPasswordVisible = false;
  bool isLoading = false;

  Future<void> login(
      BuildContext context, String email, String password) async {
    isLoading = true;
    notifyListeners();

    final user = await _auth.logInUser(email, password);

    isLoading = false;
    notifyListeners();

    if (user != null) {
      log("User Logged In");
      if (email == 'admin@gmail.com' && password == '1234567890') {
        // ignore: use_build_context_synchronously
        nextScreenReplacement(context, const HomePage());
      } else {
        // ignore: use_build_context_synchronously
        nextScreenReplacement(context, const DriverHomePage());
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login failed")),
      );
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
}
