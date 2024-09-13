import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:machine_task_2/home_page.dart';
import 'package:machine_task_2/models/authentication.dart';
import 'package:machine_task_2/models/driver.dart';
import 'package:machine_task_2/models/route.dart';
import 'package:machine_task_2/models/store.dart';
import 'package:machine_task_2/on_boarding_page.dart';
import 'package:machine_task_2/splash_screen.dart';
import 'package:machine_task_2/tab_bar_widget.dart';
import 'package:machine_task_2/user_sign_in_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AuthenticationModelsAdapter());
  Hive.registerAdapter(DriverModelsAdapter());
  Hive.registerAdapter(RouteModelsAdapter()); 
  Hive.registerAdapter(StoreModelsAdapter());

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
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const HomePage(),
    );
  }
}
