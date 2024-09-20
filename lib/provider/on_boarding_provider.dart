// import 'package:flutter/material.dart';
// import 'package:machine_task_2/user_sign_in_page.dart';
// import 'package:machine_task_2/utils/alerts_and_navigate.dart';

// class OnBoardingProvider with ChangeNotifier {
//   final PageController pageController = PageController();
//   late AnimationController animationController;
//   late Animation<double> animation;
//   int currentPage = 0;

//   OnBoardingProvider(TickerProvider vsync) {
//     animationController = AnimationController(
//         vsync: vsync, duration: const Duration(milliseconds: 300));
//     animation = Tween<double>(begin: 0, end: 1).animate(animationController);

//     pageController.addListener(() {
//       currentPage = pageController.page!.toInt();
//       notifyListeners();
//     });
//   }

//   void nextPage(BuildContext context) {
//     if (currentPage < 2) {
//       pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//       animateProgress();
//     } else {
//       // Navigate to sign-in page
//       nextScreenRemoveUntil(context, UserSignInPage());
//     }
//   }

//   void animateProgress() {
//     animationController.reset();
//     animationController.forward();
//   }

//   @override
//   void dispose() {
//     pageController.dispose();
//     animationController.dispose();
//     super.dispose();
//   }
// }
