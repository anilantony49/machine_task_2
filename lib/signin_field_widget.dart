import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:machine_task_2/constants.dart';
import 'package:machine_task_2/driver_home_page.dart';
import 'package:machine_task_2/home_page.dart';
import 'package:machine_task_2/icons.dart';
import 'package:machine_task_2/services/authentication.dart';
import 'package:machine_task_2/widgets/custom_btn.dart';
import 'package:machine_task_2/widgets/custom_txt_form_field.dart';

class SignInFieldWidget extends StatefulWidget {
  const SignInFieldWidget({super.key});

  @override
  State<SignInFieldWidget> createState() => _SignInFieldWidgetState();
}

class _SignInFieldWidgetState extends State<SignInFieldWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool _isPasswordVisible = false;
  bool isLoading = false;

  final _auth = AuthService();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> _login() async {
    // if (!mounted) return; // Check if the widget is still mounted

    // setState(() {
    //   isLoading = true;
    // });

    final user =
        await _auth.logInUser(emailController.text, passwordController.text);

    // if (mounted) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
    if (user != null) {
      log("User Logged In");
      if (emailController.text == 'admin@gmail.com' &&
          passwordController.text == '1234567890') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DriverHomePage()));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 1000),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 30),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back!',
                      style: TextStyle(
                          fontSize: 20, fontVariations: fontWeightW700),
                    ),
                    kHeight(10),
                    const Text(
                      "Enter your login details to continue.",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              kHeight(25),
              // Username field
              CustomTxtFormField(
                controller: emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value!.length < 4) {
                    return 'Email should not be empty';
                  }
                  return null;
                },
              ),
              kHeight(20),

              // Password field
              CustomTxtFormField(
                controller: passwordController,
                hintText: 'Password',
                suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: Icon(
                    _isPasswordVisible ? AppIcon.eye_slash : AppIcon.eye,
                    size: 20,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value!.length < 4) {
                    return 'Password should not be empty';
                  }
                  return null;
                },
              ),
              kHeight(25),

              // Sign in button
              CustomButton(
                buttonText: 'Sign In',
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (formKey.currentState!.validate()) {
                    _login();

                    print(
                        'Sign In with Username: ${emailController.text}, Password: ${passwordController.text}');
                    // nextScreen(context,
                    //     const SomeNextScreen()); // Example next screen navigation
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
