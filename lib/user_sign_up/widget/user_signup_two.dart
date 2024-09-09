import 'package:flutter/material.dart';
import 'package:machine_task_2/user_sign_up/widget/signup_two_field_widget.dart';
import 'package:machine_task_2/user_sign_up/widget/widgets.dart';
import 'package:machine_task_2/widgets/custom_app_bar.dart';

class UserSignUpPageTwo extends StatefulWidget {
  const UserSignUpPageTwo({
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
  State<UserSignUpPageTwo> createState() => _UserSignUpPageTwoState();
}

class _UserSignUpPageTwoState extends State<UserSignUpPageTwo> {
  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        extendBodyBehindAppBar: true,
        appBar: CustomAppbar.show(context, true),
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: mediaHeight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SignUpTwoFieldWidget(
                    email: widget.email,
                    phoneNo: widget.phoneNo,
                    fullName: widget.fullName,
                    accountType: widget.accountType,
                  ),
                  Positioned(
                    bottom: 0,
                    child: SignUpWidgets.signInNavigate(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}