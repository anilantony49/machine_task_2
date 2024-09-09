import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:machine_task_2/constants.dart';
import 'package:machine_task_2/icons.dart';
import 'package:machine_task_2/widgets/custom_btn.dart';
import 'package:machine_task_2/widgets/custom_txt_form_field.dart';

class SignInFieldWidget extends StatefulWidget {
  const SignInFieldWidget({super.key});

  @override
  State<SignInFieldWidget> createState() => _SignInFieldWidgetState();
}

class _SignInFieldWidgetState extends State<SignInFieldWidget> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool _isPasswordVisible = false; // Used to toggle password visibility

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
                controller: usernameController,
                hintText: 'Username',
                validator: (value) {
                  if (value!.length < 4) {
                    return 'Username should not be empty';
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
                    // Simulate sign-in without Bloc
                    // Perform sign-in logic here, e.g., API call
                    // Then navigate to the next screen or show an error
                    // For now, just print the username and password
                    print(
                        'Sign In with Username: ${usernameController.text}, Password: ${passwordController.text}');
                    // nextScreen(context,
                    //     const SomeNextScreen()); // Example next screen navigation
                  }
                },
              ),
              kHeight(10),
              InkWell(
                onTap: () {
                  // nextScreen(context, const ForgotPasswordPage());
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Forget Password?',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
