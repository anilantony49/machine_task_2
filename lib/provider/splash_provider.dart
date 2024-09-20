import 'package:flutter/material.dart';
import 'package:machine_task_2/services/shared_preference.dart';
import 'package:machine_task_2/utils/alerts_and_navigate.dart';
import 'package:machine_task_2/screens/admin/home_page.dart';
import 'package:machine_task_2/screens/on_boarding_screen/on_boarding_page.dart';
import 'package:machine_task_2/screens/user_sign_in/widgets/user_sign_in_page.dart';

class SplashProvider extends ChangeNotifier {
  Future<void> checkUserStatus(BuildContext context) async {
    final userOnInitial = await UserAuthStatus.isUserOnInitial();
    final userSignIn = await UserAuthStatus.getUserStatus();

    if (userOnInitial == false) {
      // ignore: use_build_context_synchronously
      nextScreen(context, const OnBoardingPage());
    } else {
      if (userSignIn == false) {
        await Future.delayed(const Duration(milliseconds: 2500));
        // ignore: use_build_context_synchronously
        nextScreenRemoveUntil(context, UserSignInPage());
      } else {
        await Future.delayed(const Duration(milliseconds: 2500));
        // ignore: use_build_context_synchronously
        nextScreenRemoveUntil(context, const HomePage());
      }
    }
    notifyListeners();
  }
}
