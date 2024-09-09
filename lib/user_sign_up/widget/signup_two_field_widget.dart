import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:machine_task_2/constants.dart';
import 'package:machine_task_2/icons.dart';
import 'package:machine_task_2/widgets/custom_btn.dart';
import 'package:machine_task_2/widgets/custom_txt_form_field.dart';

class SignUpTwoFieldWidget extends StatefulWidget {
  const SignUpTwoFieldWidget({
    super.key,
    required this.email,
    required this.phoneNo,
    required this.fullName,
    required this.accountType,
  });

  final String email;
  final String phoneNo;
  final String fullName;
  final String accountType;

  @override
  State<SignUpTwoFieldWidget> createState() => _SignUpTwoFieldWidgetState();
}

class _SignUpTwoFieldWidgetState extends State<SignUpTwoFieldWidget> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
              // Username field
              CustomTxtFormField(
                hintText: 'Username',
                controller: userNameController,
                validator: (val) {
                  if (val!.length < 4) {
                    return 'Username should have at least 4 characters';
                  }
                  if (val.endsWith('.') || val.endsWith('_')) {
                    return "Username can't end with period or underscore";
                  }
                  if (!RegExp(r"^(?=.{4,20}$)(?![_.])[a-zA-Z0-9._]+(?<![_.])$")
                      .hasMatch(val)) {
                    return 'Username can only use letters, numbers, underscores, and periods';
                  }
                  return null;
                },
              ),

              // Create password field
              kHeight(20),
              CustomTxtFormField(
                hintText: 'Create password',
                controller: passWordController,
                validator: (val) {
                  // if (!RegExp(passowrdRegexPattern).hasMatch(val!)) {
                  //   return 'Passwords should be 8 characters, at least one number and one special character';
                  // }
                  // return null;
                },
                obscureText: _obscurePassword,
                suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  child: Icon(
                    _obscurePassword ? AppIcon.eye_slash : AppIcon.eye,
                    size: 20,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              kHeight(20),

              // Confirm password field
              CustomTxtFormField(
                hintText: 'Confirm password',
                controller: confirmPasswordController,
                validator: (val) {
                  // if (!RegExp(passowrdRegexPattern).hasMatch(val!)) {
                  //   return 'Passwords should be 8 characters, at least one number and one special character';
                  // }
                  // return null;
                },
                obscureText: _obscureConfirmPassword,
                suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  child: Icon(
                    _obscureConfirmPassword ? AppIcon.eye_slash : AppIcon.eye,
                    size: 20,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              kHeight(25),

              // Sign Up button
              CustomButton(
                buttonText: 'Sign Up',
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (passWordController.text == confirmPasswordController.text) {
                    if (formKey.currentState!.validate()) {
                      // Perform sign up action here, e.g., call API
                      // For example:
                      // signUp(widget.email, userNameController.text, passWordController.text);
                    }
                  } else {
                    // customSnackbar(context, "Passwords don't match",
                    //     leading: Ktweel.shield_cross, trailing: 'OK');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // Example function for sign-up action
  // Future<void> signUp(String email, String username, String password) async {
  //   // Implement your sign-up logic here, e.g., call an API
  // }
}
