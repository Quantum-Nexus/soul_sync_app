import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soul_sync_app/Screens/DataCollectionScreen/components/mobile_no.dart';
import 'package:soul_sync_app/Screens/DataCollectionScreen/userInfo.dart';
import 'package:soul_sync_app/Screens/LoginScreen/components/otp_screen.dart';
import 'package:soul_sync_app/Screens/LoginScreen/login_screen.dart';
import '../../utils/constants/color.dart';
import 'components/inputField.dart';

class SignupScreen extends StatefulWidget {
  final void Function()? onTap;

  const SignupScreen({Key? key, this.onTap}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  bool isFirstNameValid = true;
  bool isLastNameValid = true;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;

  void signUp() async {
    // showDialog(context: context, builder: (context){
    //   return Center(
    //     child: CircularProgressIndicator(color: kSecondaryColor),
    //   );
    // });

    if (!isFieldsValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords don't match!")),
      );
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MobileNo(
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              email: emailController.text,
              password: passwordController.text,
              confirmPassword: confirmController.text,
            )));

    const url = 'http://localhost:4000/api/v1/auth/sendotp';

    // final response = await http.post(
    //   Uri.parse(url),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({
    //     'email': emailController.text,
    //     'password': passwordController.text,
    //     'confirmPassword': confirmController.text,
    //     'firstName': firstNameController.text,
    //     'lastName': lastNameController.text,
    //   }),
    // );

    // if (response.statusCode == 200) {
    //   Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => OTPScreen(
    //       confirmController: confirmController.text,
    //       emailController: emailController.text,
    //       firstNameController: firstNameController.text,
    //       lastNameController: lastNameController.text,
    //       passwordController: passwordController.text,
    //     ),
    //   ));
    // }
    // else {
    //   final responseBody = json.decode(response.body);

    //   if (responseBody.containsKey('message')) {
    //     final errorMessage = responseBody['message'];

    //     if (errorMessage.contains('User is Already Registered')) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(content: Text('Email already exists. Please log in.')),
    //       );
    //     } else {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text(errorMessage)),
    //       );
    //     }
    //   }
    // }
  }

  bool isFieldsValid() {
    setState(() {
      isFirstNameValid = firstNameController.text.isNotEmpty;
      isLastNameValid = lastNameController.text.isNotEmpty;
      isEmailValid = emailController.text.isNotEmpty;
      isPasswordValid = passwordController.text.isNotEmpty;
      isConfirmPasswordValid = confirmController.text.isNotEmpty;
    });

    return isFirstNameValid &&
        isLastNameValid &&
        isEmailValid &&
        isPasswordValid &&
        isConfirmPasswordValid;
  }

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

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
                  style: kLogo1Style,
                ),
              ),
              const Center(
                  child: Text(
                'Signup',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Rubik Medium',
                    color: kSecondaryLightColor),
              )),
              const Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Create your Account',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Rubik Regular',
                      color: kTextColor),
                ),
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          fillColor: kSecondaryLightColor,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: kSecondaryColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffE4E7EB),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffE4E7EB),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          fillColor: kSecondaryLightColor,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: kSecondaryColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffE4E7EB),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffE4E7EB),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InputField(
                passwordcontroller: passwordController,
                emailcontroller: emailController,
                // isEmailValid: isEmailValid,
                // isPasswordValid: isPasswordValid,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: TextFormField(
                  obscureText: passwordVisible,
                  controller: confirmController,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    fillColor: kSecondaryLightColor,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: kSecondaryColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      color: kSecondaryColor,
                      onPressed: () {
                        setState(
                          () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffE4E7EB),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffE4E7EB),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  signUp();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: kSecondaryLightColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'Rubik Regular',
                              fontSize: 20,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already a member?',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik Regular',
                        color: kSecondaryLightColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        ' Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik Medium',
                          color: Colors.white,
                        ),
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
