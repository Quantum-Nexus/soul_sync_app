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
              SizedBox(
                height: 100,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Get on Board', style: kDHead2Style),
                    Text(
                      "  Begin Your Soulful Journey Today",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Rubik Regular',
                      color: Colors.white54),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
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
                        style: const TextStyle(color: kPrimaryLightColor),
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kPrimaryLightColor, width: 0.25),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: "First Name",
                          hintText: " First Name",
                          hintStyle: TextStyle(color: Colors.white38),
                          hintMaxLines: 3,
                          labelStyle: TextStyle(color: kPrimaryLightColor),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: kPrimaryLightColor,
                          ), // Hint text color
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: kPrimaryLightColor,
                                width: 0.25), // Border color
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        controller: lastNameController,
                        style: const TextStyle(color: kPrimaryLightColor),
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kPrimaryLightColor, width: 0.25),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Last Name",
                          hintText: " Last Name",
                          hintStyle: TextStyle(color: Colors.white38),
                          hintMaxLines: 3,
                          labelStyle: TextStyle(color: kPrimaryLightColor),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: kPrimaryLightColor,
                          ), // Hint text color
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: kPrimaryLightColor,
                                width: 0.25), // Border color
                          ),
                        ), // Add validator
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
                  style: const TextStyle(color: kPrimaryLightColor),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kPrimaryLightColor, width: 0.25),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.white38),
                    hintMaxLines: 3,
                    labelStyle: TextStyle(color: kPrimaryLightColor),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: kPrimaryLightColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      color: kPrimaryLightColor,
                      onPressed: () {
                        setState(
                          () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: kPrimaryLightColor,
                          width: 0.25), // Border color
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              GestureDetector(
                onTap: () {
                  signUp();
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
                      'Continue',
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
                padding: const EdgeInsets.all(40.0),
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
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik Medium',
                          color: kPinkColor,
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
