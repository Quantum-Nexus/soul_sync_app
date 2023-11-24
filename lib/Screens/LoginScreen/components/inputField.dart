import 'package:flutter/material.dart';
import '../../../utils/constants/color.dart';

class InputField extends StatefulWidget {
  final TextEditingController emailcontroller;
  final TextEditingController passwordcontroller;
  const InputField({
    Key? key,
    required this.passwordcontroller,
    required this.emailcontroller,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // You can add additional email validation logic here if needed
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // You can add additional password validation logic here if needed
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextFormField(
            controller: widget.emailcontroller,
            validator: validateEmail,
            cursorColor: kPrimaryLightColor,
            style: const TextStyle(color: kPrimaryLightColor),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryLightColor, width: 0.25),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: OutlineInputBorder(),
              labelText: 'Email',
              hintText: " example@gmail.com",
              hintStyle: TextStyle(color: Colors.white38),
              hintMaxLines: 3,
              labelStyle: TextStyle(color: kPrimaryLightColor),
              prefixIcon: const Icon(
                Icons.email,
                color: kPrimaryLightColor,
              ), // Hint text color
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: kPrimaryLightColor, width: 0.25), // Border color
              ),
            ), // Add validator
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: TextFormField(
            controller: widget.passwordcontroller,
            obscureText: passwordVisible,
            validator: validatePassword,
            cursorColor: kPrimaryLightColor,
            style: const TextStyle(color: kPrimaryLightColor),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryLightColor, width: 0.25),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: OutlineInputBorder(),
              labelText: 'Password',
              hintStyle: TextStyle(color: Colors.white38),
              hintMaxLines: 3,
              labelStyle: TextStyle(color: kPrimaryLightColor),
              prefixIcon: Icon(
                Icons.lock,
                color: kPrimaryLightColor,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility),
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
                    color: kPrimaryLightColor, width: 0.25), // Border color
              ),
            ), // Add validator
            
          ),
        ),
      ],
    );
  }
}
