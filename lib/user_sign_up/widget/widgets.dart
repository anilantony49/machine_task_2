import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:machine_task_2/alerts_and_navigate.dart';
import 'package:machine_task_2/sign_in_screen.dart';
import 'package:machine_task_2/widgets/custom_btn.dart';
import 'package:machine_task_2/widgets/custom_txt_form_field.dart';

class SignUpWidgets {
  static FadeInUp signInNavigate(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 1000),
      child: InkWell(
        onTap: () {
          nextScreenRemoveUntil(context, const UserSignInPage());
        },
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Already have an account? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const TextSpan(text: 'Sign In.'),
            ],
          ),
        ),
      ),
    );
  }

  static Future<dynamic> validateEmail({
    BuildContext? context,
    String? email,
    String? phoneNo,
    String? fullName,
    String? accountType,
    String? password,
    String? username,
    TextEditingController? otpController,
  }) {
    final GlobalKey<FormState> formKey = GlobalKey();

    return showDialog(
      context: context!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Verification',
            style: TextStyle(
               fontWeight: FontWeight.w600,
               color: Theme.of(context).colorScheme.primary),
          ),
          content: const Text(
              'A 6-Digit OTP has been sent to your email address, enter it below to continue'),
          actions: [
            Column(
              children: [
                Form(
                  key: formKey,
                  child: CustomTxtFormField(
                    hintText: 'OTP',
                    controller: otpController,
                    validator: (val) {
                      if (val!.length < 6) {
                        return "Please enter a valid OTP";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  buttonText: 'Sign Up',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      // Handle the sign-up logic here
                      // final user = UserModel(
                      //   accountType: accountType,
                      //   username: username,
                      //   password: password,
                      //   email: email,
                      //   fullName: fullName,
                      //   phoneNumber: int.parse(phoneNo ?? '0'),
                      //   otp: otpController!.text,
                      // );

                      // Replace with actual sign-up logic
                      // debugPrint('User Signed Up: ${user.username}');
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
