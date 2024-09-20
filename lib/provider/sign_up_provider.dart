import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:machine_task_2/services/authentication.dart';

import 'package:machine_task_2/screens/user_sign_in/widgets/user_sign_in_page.dart';
import 'package:machine_task_2/utils/alerts_and_navigate.dart';

class SignUpProvider extends ChangeNotifier {
  final AuthService _auth = AuthService();
  bool isPasswordVisible = false;
  bool isLoading = false;

  Future<void> signUp(
      BuildContext context, String email, String password, String name) async {
    isLoading = true;
    notifyListeners();

    final user = await _auth.signUPUser(email, password, name);

    isLoading = false;
    notifyListeners();

    if (user != null) {
      log("User Created Successfully");
      nextScreenReplacement(context, UserSignInPage());
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
}
