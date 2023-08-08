import 'package:flutter/material.dart';

import '../../utils/constants/color.dart';
import 'components/inputField.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key, this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(70.0),
                child: Text(
                  'Soul Sync',
                  style: kLogoStyle,
                ),
              ),
             // SizedBox(height: 10,),
              const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Rubik Medium',
                        color: kSecondaryLightColor
                    ),
                  )),
              const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Enter Your Email and Password',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik Regular',
                          color: kTextColor),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: InputField(
                  passwordcontroller: passwordController,
                  emailcontroller: emailController,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik Regular',
                        color: kSecondaryLightColor,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: (){
                  //signIn();
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: kSecondaryLightColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'login',
                      style: TextStyle(
                        fontFamily: 'Rubik Regular',
                        fontSize: 20,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(
                      'Dont have an account?',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik Regular',
                          color: kSecondaryLightColor),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        ' Signup',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik Medium',
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}