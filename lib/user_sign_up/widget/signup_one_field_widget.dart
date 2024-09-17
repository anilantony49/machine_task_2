import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:machine_task_2/alerts_and_navigate.dart';
import 'package:machine_task_2/constants.dart';
import 'package:machine_task_2/driver_home_page.dart';
import 'package:machine_task_2/home_page.dart';
import 'package:machine_task_2/services/authentication.dart';
import 'package:machine_task_2/sign_in_screen.dart';
import 'package:machine_task_2/user_sign_up/widget/user_signup_two.dart';
import 'package:machine_task_2/validations.dart';
import 'package:machine_task_2/widgets/custom_btn.dart';
import 'package:machine_task_2/widgets/custom_txt_form_field.dart';

class SignUpOneFieldWidget extends StatefulWidget {
  const SignUpOneFieldWidget({super.key});

  @override
  State<SignUpOneFieldWidget> createState() => _SignUpOneFieldWidgetState();
}

class _SignUpOneFieldWidgetState extends State<SignUpOneFieldWidget> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  final _auth = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullnameController.dispose();
    super.dispose();
  }

  _signUp() async {
    final user = await _auth.signUPUser(
      emailController.text,
      passwordController.text,
      fullnameController.text,
    );

    if (user != null) {
      log("User Created Successfully");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const UserSignInPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 1000),
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create an account',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  kHeight(10),
                  const Text(
                    "Please enter your information and create your account.",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              kHeight(25),
              // Full name field
              CustomTxtFormField(
                hintText: 'Full name',
                controller: fullnameController,
                validator: (val) {
                  if (val!.length < 3) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
              ),
              kHeight(20),

              // Email address field
              CustomTxtFormField(
                hintText: 'Email address',
                controller: emailController,
                validator: (val) {
                  if (!RegExp(emailRegexPattern).hasMatch(val!) ||
                      val.isEmpty) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              kHeight(20),

              // Phone number field
              CustomTxtFormField(
                hintText: 'Password',
                controller: passwordController,
                validator: (val) {
                  if (val!.length < 10) {
                    return 'Enter a valid password';
                  }
                  return null;
                },
              ),
              kHeight(20),

              CustomButton(
                buttonText: 'Sign Up',
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (formKey.currentState!.validate()) {
                    _signUp();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
