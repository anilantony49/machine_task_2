import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:machine_task_2/provider/driver_home_provider.dart';
import 'package:machine_task_2/provider/driver_provider.dart';
import 'package:machine_task_2/provider/retail_shop_provider.dart';
import 'package:machine_task_2/provider/route_detail_provider.dart';
import 'package:machine_task_2/provider/sign_in_provider.dart';
import 'package:machine_task_2/provider/sign_up_provider.dart';
import 'package:machine_task_2/provider/splash_provider.dart';
import 'package:machine_task_2/screens/admin/home_page.dart';
import 'package:machine_task_2/models/authentication.dart';
import 'package:machine_task_2/models/driver.dart';
import 'package:machine_task_2/models/route.dart';
import 'package:machine_task_2/models/store.dart';
import 'package:machine_task_2/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => RetailShopProvider()),
        ChangeNotifierProvider(create: (context) => DriverProvider()),
        ChangeNotifierProvider(create: (context) => DriverHomeProvider()),
        ChangeNotifierProvider(create: (context) => RouteDetailProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: GoogleFonts.aBeeZeeTextTheme(),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomePage();
                } else {
                  return const SplashPage();
                }
              })),
    );
  }
}
