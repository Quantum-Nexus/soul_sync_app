import 'package:flutter/material.dart';
import 'package:soul_sync_app/Screens/Home/home.dart';
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
      initialRoute: '/splash',
      routes: {
        '/home': (context) => const Home(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/splash': (context) => const SplashScreen(),
        //'/feed': (context) => const FeedScreen(),
        '/login': (context) => const LoginScreen(),
        //'/timetable': (context) => const TimetableHome(),
        //'/notification': (context) => const NotificationScreen(),
      },
    );
  }
}

