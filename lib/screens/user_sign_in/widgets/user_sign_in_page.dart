import 'package:flutter/material.dart';
import 'package:machine_task_2/screens/user_sign_in/widgets/signin_field_widget.dart';
import 'package:machine_task_2/screens/user_sign_in/widgets/widgets.dart';

class UserSignInPage extends StatelessWidget {
  UserSignInPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF9F6),
        extendBodyBehindAppBar: true,
        // appBar: CustomAppbar.show(context, false),
        body: SingleChildScrollView(
          child: Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const SignInFieldWidget(),
                  Positioned(
                    bottom: 0,
                    child: SignInWidgets.signUpNavigate(context),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
