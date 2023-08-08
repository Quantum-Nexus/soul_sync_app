import 'package:flutter/material.dart';
import 'package:soul_sync_app/Screens/Home/home.dart';
import 'package:soul_sync_app/Screens/LoginScreen/signup_screen.dart';
import 'package:soul_sync_app/Screens/SplashScreen/splash_screen.dart';

import 'Screens/LoginScreen/login_screen.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/home': (context) => const Home(),
        '/splash': (context) => const SplashScreen(),
        //'/feed': (context) => const FeedScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        //'/timetable': (context) => const TimetableHome(),
        //'/notification': (context) => const NotificationScreen(),
      },
    );
  }
}

