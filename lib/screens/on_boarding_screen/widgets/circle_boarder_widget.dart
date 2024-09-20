import 'dart:math';

import 'package:flutter/material.dart';

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