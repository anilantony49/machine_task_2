import 'package:flutter/material.dart';
import 'package:machine_task_2/utils/alerts_and_navigate.dart';
import 'package:machine_task_2/screens/user_sign_up/user_signup_one.dart';

class SignInWidgets {
  static InkWell signUpNavigate(context) {
    return InkWell(
      onTap: () => nextScreen(context, const UserSignUpPageOne()),
      child: const Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: "Don't have an account yet? ",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: 'Sign Up.',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
