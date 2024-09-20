import 'package:flutter/material.dart';
import 'package:machine_task_2/provider/sign_in_provider.dart';
import 'package:machine_task_2/utils/constants.dart';
import 'package:machine_task_2/utils/icons.dart';
import 'package:machine_task_2/widgets/custom_btn.dart';
import 'package:machine_task_2/widgets/custom_txt_form_field.dart';
import 'package:provider/provider.dart';

class SignInFieldWidget extends StatefulWidget {
  const SignInFieldWidget({super.key});

  @override
  State<SignInFieldWidget> createState() => _SignInFieldWidgetState();
}

class _SignInFieldWidgetState extends State<SignInFieldWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  // bool _isPasswordVisible = false;
  // bool isLoading = false;

  // final _auth = AuthService();

  // @override
  // void dispose() {
  //   super.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  // }

  // Future<void> _login() async {
  //   // if (!mounted) return; // Check if the widget is still mounted

  //   // setState(() {
  //   //   isLoading = true;
  //   // });

  //   final user =
  //       await _auth.logInUser(emailController.text, passwordController.text);

  //   // if (mounted) {
  //   //   setState(() {
  //   //     isLoading = false;
  //   //   });
  //   // }
  //   if (user != null) {
  //     log("User Logged In");
  //     if (emailController.text == 'admin@gmail.com' &&
  //         passwordController.text == '1234567890') {
  //       // ignore: use_build_context_synchronously
  //       nextScreenReplacement(context, const HomePage());
  //     } else {
  //       // ignore: use_build_context_synchronously
  //       nextScreenReplacement(context, const DriverHomePage());
  //     }
  //   } else {
  //     // ignore: use_build_context_synchronously
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text("Login failed")));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    style:
                        TextStyle(fontSize: 20, fontVariations: fontWeightW700),
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
            Consumer<SignInProvider>(
              builder: (context, provider, child) {
                return CustomTxtFormField(
                  controller: passwordController,
                  hintText: 'Password',
                  suffix: GestureDetector(
                    onTap: () {
                      provider.togglePasswordVisibility();
                    },
                    child: Icon(
                      provider.isPasswordVisible
                          ? AppIcon.eye
                          : AppIcon.eye_slash,
                      size: 20,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  obscureText: !provider.isPasswordVisible,
                  validator: (value) {
                    if (value!.length < 4) {
                      return 'Password should not be empty';
                    }
                    return null;
                  },
                );
              },
            ),
            kHeight(25),

            // Sign in button
            Consumer<SignInProvider>(
              builder: (context, provider, child) {
                return CustomButton(
                  buttonText: 'Sign In',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      provider.login(
                        context,
                        emailController.text,
                        passwordController.text,
                      );

                      print(
                          'Sign In with Username: ${emailController.text}, Password: ${passwordController.text}');
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
