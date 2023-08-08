import 'package:flutter/material.dart';
import 'package:soul_sync_app/Screens/LoginScreen/login_screen.dart';
import 'package:soul_sync_app/Screens/LoginScreen/signup_screen.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginScreen(onTap: togglePages); }
        else{
          return SignupScreen(onTap: togglePages);
        }


    }
  }

