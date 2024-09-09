import 'dart:async';

import 'package:flutter/material.dart';
import 'package:machine_task_2/home_page.dart';
import 'package:machine_task_2/on_boarding_page.dart';
import 'package:machine_task_2/splash_screen.dart';
import 'package:machine_task_2/user_sign_in_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
