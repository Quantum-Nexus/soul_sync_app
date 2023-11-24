import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:soul_sync_app/Screens/LoginScreen/signup_screen.dart';
import '../../utils/constants/color.dart';
import '../Home/home.dart';
import 'components/inputField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //final storage = const FlutterSecureStorage();

  void signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Lottie.asset(
              'assets/images/loader.json',
              width: 300,
              height: 300,
            ),
          );
        });

    const url =
        'http://localhost:4000/api/v1/auth/login'; // Replace with your actual API endpoint

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    print(response);

    if (response.statusCode == 200) {
      // Navigator.pop(context);
      final responseBody = json.decode(response.body);
      print(responseBody);
      final user = responseBody['user'];
      final firstName = user['firstName'];
      final lastName = user['lastName'];
      final gender = user['gender'];
      final userId = user['_id']; // Access the 'firstName' field
      print(firstName);

      final jwtToken = responseBody['token'];

      // Store the JWT token securely
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('jwt_token', jwtToken);
      prefs.setString('first_name', firstName);
      prefs.setString('last_name', lastName);
      prefs.setString('gender', gender);
      prefs.setString('userId', userId);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
    } else {
      final responseBody = json.decode(response.body);
      if (responseBody.containsKey('message')) {
        final errorMessage = responseBody['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    //passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome Back', style: kDHead2Style),
                    Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(
                        "We've missed you! Please sign in to catch up on what you've missed",
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Rubik Regular',
                            color: Colors.white54),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: InputField(
                  passwordcontroller: passwordController,
                  emailcontroller: emailController,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik Regular',
                        color: kPrimaryLightColor,
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
                onTap: () {
                  signIn();
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'login',
                      style: TextStyle(
                        fontFamily: 'Rubik Regular',
                        fontSize: 20,
                        color: Colors.black,
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
                  children: [
                    const Text(
                      'Dont have an account?',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik Regular',
                          color: kPrimaryLightColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignupScreen()));
                      },
                      child: const Text(
                        ' Register here',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rubik Medium',
                            color: kPinkColor),
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
