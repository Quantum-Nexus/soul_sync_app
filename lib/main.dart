import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sync_app/Screens/DataCollectionScreen/components/aboutme.dart';

import 'package:soul_sync_app/Screens/DataCollectionScreen/components/gender_info.dart';
import 'package:soul_sync_app/Screens/DataCollectionScreen/components/mobile_no.dart';
import 'package:soul_sync_app/Screens/DataCollectionScreen/userInfo.dart';
import 'package:soul_sync_app/Screens/Home/home.dart';
import 'package:soul_sync_app/Screens/LoginScreen/signup_screen.dart';
import 'package:soul_sync_app/Screens/SplashScreen/splash_screen.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

import 'Screens/LoginScreen/login_screen.dart';
import 'Screens/Onboarding/onboarding.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getString('jwt_token') != null;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

// Future<bool> checkToken() async {
//   const storage = FlutterSecureStorage();
//   String? token = await storage.read(key: 'jwt_token');
//   return token != null && token.isNotEmpty;
// }

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoulSync',

      theme: ThemeData(
        primarySwatch: kPrimarySwatch,
      ),

      debugShowCheckedModeBanner: false,
      initialRoute: '/data', //isLoggedIn ? '/home' : '/splash',
      routes: {
        '/home': (context) => const Home(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/splash': (context) => const SplashScreen(),
        // '/otp': (context) => OTPScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/data': (context) => const AboutMe(),
        //'/timetable': (context) => const TimetableHome(),
        // '/form': (context) =>  ProfileForm(),
        //'/timetable': (context) => const TimetableHome(),
        //'/notification': (context) => const NotificationScreen(),
      },
    );
  }
}

