import 'package:flutter/material.dart';
import 'package:soul_sync_app/Screens/Home/home.dart';
import 'package:soul_sync_app/Screens/LoginScreen/components/otp_screen.dart';
import 'package:soul_sync_app/Screens/LoginScreen/signup_screen.dart';
import 'package:soul_sync_app/Screens/SplashScreen/splash_screen.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

import 'Screens/LoginScreen/login_screen.dart';
import 'Screens/Onboarding/onboarding.dart';
import 'Screens/SplashScreen/splash_screen.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoulSync',

      theme: ThemeData(
        primarySwatch: kPrimarySwatch,
      ),

      debugShowCheckedModeBanner: false,
      initialRoute: '/otp',
      routes: {
        '/home': (context) => const Home(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/splash': (context) => const SplashScreen(),
        '/otp': (context) => OTPScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        //'/timetable': (context) => const TimetableHome(),
        //'/notification': (context) => const NotificationScreen(),
      },
    );
  }
}

