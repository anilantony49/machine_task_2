import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:machine_task_2/alerts_and_navigate.dart';
import 'package:machine_task_2/user_sign_up/user_signup_one.dart';

class SignInWidgets {
  static InkWell signUpNavigate(context) {
    return InkWell(
      onTap: () => nextScreen(context, const UserSignUpPageOne()),
      child: FadeInUp(
        delay: const Duration(milliseconds: 700),
        duration: const Duration(milliseconds: 1000),
        child: const Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(
                text: "Don't have an account yet? ",
                style: TextStyle(
                  color:Colors.black,
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
      ),
    );
  }
}
