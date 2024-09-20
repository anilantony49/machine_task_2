// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:machine_task_2/provider/splash_provider.dart';
import 'package:machine_task_2/utils/alerts_and_navigate.dart';
import 'package:machine_task_2/screens/admin/home_page.dart';
import 'package:machine_task_2/screens/on_boarding_screen/on_boarding_page.dart';
import 'package:machine_task_2/services/shared_preference.dart';
import 'package:machine_task_2/screens/user_sign_in/widgets/user_sign_in_page.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // @override
  // void initState() {
  //   checkUserStatus();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
     // Call the provider to check user status as soon as the page builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashProvider>(context, listen: false).checkUserStatus(context);
    });
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: const Text(
          'ChillDairy',
          style: TextStyle(fontSize: 35),
        )
            .animate()
            .shimmer(delay: 400.ms, duration: 1000.ms)
            // .shake(hz: 4, curve: Curves.easeInOutCubic)
            .scaleXY(end: 1.1, duration: 600.ms)
            .then(delay: 600.ms)
            .scaleXY(end: 1 / 1.1),
      ),
    );
  }

  // Future<void> checkUserStatus() async {
  //   final userOnInitial = await UserAuthStatus.isUserOnInitial();
  //   final userSignIn = await UserAuthStatus.getUserStatus();
  //   if (userOnInitial == false) {
  //     nextScreen(context, const OnBoardingPage());
  //   } else {
  //     if (userSignIn == false) {
  //       await Future.delayed(2500.ms);
  //       nextScreenRemoveUntil(context, UserSignInPage());
  //     } else {
  //       await Future.delayed(2500.ms);
  //       nextScreenRemoveUntil(context, const HomePage());
  //     }
  //   }
  // }
}
