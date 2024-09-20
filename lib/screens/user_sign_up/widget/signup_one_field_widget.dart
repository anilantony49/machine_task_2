import 'package:flutter/material.dart';
import 'package:machine_task_2/provider/sign_up_provider.dart';
import 'package:machine_task_2/utils/constants.dart';
import 'package:machine_task_2/utils/validations.dart';
import 'package:machine_task_2/widgets/custom_btn.dart';
import 'package:machine_task_2/widgets/custom_txt_form_field.dart';
import 'package:provider/provider.dart';

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
  // bool isLoading = false;
  // final _auth = AuthService();

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   fullnameController.dispose();
  //   super.dispose();
  // }

  // _signUp() async {
  //   final user = await _auth.signUPUser(
  //     emailController.text,
  //     passwordController.text,
  //     fullnameController.text,
  //   );

  //   if (user != null) {
  //     log("User Created Successfully");
  //     nextScreenReplacement(context, const UserSignInPage());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                if (!RegExp(emailRegexPattern).hasMatch(val!) || val.isEmpty) {
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

            Consumer<SignUpProvider>(
              builder: (context, provider, child) {
                return CustomButton(
                  buttonText: 'Sign Up',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      provider.signUp(context, emailController.text,
                          passwordController.text, fullnameController.text);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
