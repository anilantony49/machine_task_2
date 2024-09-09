import 'package:flutter/material.dart';


class UserSignInPage extends StatefulWidget {
  const UserSignInPage({super.key});

  @override
  State<UserSignInPage> createState() => _UserSignInPageState();
}

class _UserSignInPageState extends State<UserSignInPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // backgroundColor: Theme.of(context).colorScheme.surface,
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
                  // const SignInFieldWidget(),
                  // Positioned(
                  //   bottom: 0,
                  //   // child: SignInWidgets.signUpNavigate(context),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
