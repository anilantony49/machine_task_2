import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:machine_task_2/icons.dart';

class CustomAppbar {
  static AppBar show(BuildContext context, enableIcon) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: enableIcon
          ? FadeInLeft(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 1000),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(AppIcon.arrow_left),
              ),
            )
          : const SizedBox(),
      title: FadeInDown(
        delay: const Duration(milliseconds: 400),
        duration: const Duration(milliseconds: 1000),
        child: const Text(
          '',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
