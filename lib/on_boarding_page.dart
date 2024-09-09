import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:machine_task_2/alerts_and_navigate.dart';
import 'package:machine_task_2/constants.dart';
import 'package:machine_task_2/shared_preference.dart';
import 'package:machine_task_2/user_sign_in_page.dart';
import 'dart:math';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    // Initialize the animation with a tween from 0 to 1
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      // Animate the progress increase
      _animateProgress();
    } else {
      UserAuthStatus.saveUserinitialStatus(true);
      nextScreenRemoveUntil(context, const UserSignInPage());
    }
  }

  // Function to trigger animation
  void _animateProgress() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ColorfulSafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 20),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 400,
                width: double.infinity,
                child: PageView(
                  controller: _pageController,
                  children: [
                    _buildPage('assets/images/image_2.png',
                        'Efficient dairy production and delivery, from farm to store'),
                    _buildPage('assets/images/image_2.png',
                        'Fresh dairy products delivered daily by our dedicated team '),
                    _buildPage('assets/images/image_2.png',
                        'From cold storage to your doorstep, ensuring quality in every step.'),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: CircleBorderPainter(
                        progress: ((_currentPage + _animation.value) / 3)),
                    child: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary,
                      radius: 25,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: theme.colorScheme.onPrimary,
                        ),
                        onPressed: _nextPage,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(String imagePath, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class CircleBorderPainter extends CustomPainter {
  final double progress;

  CircleBorderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    // ..strokeCap = StrokeCap.square;

    double startAngle = -pi / 2; // Start at the top
    double sweepAngle = 2 * pi * progress; // Proportion of the circle to fill

    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 30);

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
