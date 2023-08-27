import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sync_app/Screens/Onboarding/onboarding.dart';
import 'package:soul_sync_app/utils/constants/logo.dart';

import '../../utils/constants/color.dart';
import '../Home/home.dart';
import '../LoginScreen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2)); // Change the duration as needed

    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getString('jwt_token') != null;

    Widget nextScreen;
    if (isLoggedIn) {
      nextScreen = Home();
    } else {
      nextScreen = OnboardingScreen();
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedSplashScreen(
          splashIconSize: height,
          duration: 3000,
          splash: Logo(),
          nextScreen: Container(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: kPrimaryColor),
    );
  }
}