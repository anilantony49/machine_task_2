import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:machine_task_2/alerts_and_navigate.dart';
import 'package:machine_task_2/constants.dart';
import 'package:machine_task_2/user_sign_up/widget/user_signup_two.dart';
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
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

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
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                  // if (!RegExp(emailRegexPattern).hasMatch(val!) ||
                  //     val.isEmpty) {
                  //   return 'Enter a valid email';
                  // }
                  // return null;
                },
              ),
              kHeight(20),

              // Phone number field
              CustomTxtFormField(
                hintText: 'Phone number',
                controller: phoneNumberController,
                validator: (val) {
                  if (val!.length < 10) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              kHeight(20),

              // Account type field (assuming this field is now unnecessary)
              // You might want to include the account type selection UI here

              // Continue button
              CustomButton(
                buttonText: 'Continue',
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (formKey.currentState!.validate()) {
                    nextScreen(
                      context,
                      UserSignUpPageTwo(
                        email: emailController.text,
                        accountType: accountTypeController.text, // Update to use the controller's text
                        fullName: fullnameController.text,
                        phoneNo: phoneNumberController.text,
                      ),
                    );
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
