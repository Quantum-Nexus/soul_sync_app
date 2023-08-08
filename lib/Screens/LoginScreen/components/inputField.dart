import 'package:flutter/material.dart';

import '../../../utils/constants/color.dart';



class InputField extends StatefulWidget {
  final TextEditingController emailcontroller;
  final TextEditingController passwordcontroller;
  const InputField({Key? key, required this.passwordcontroller, required this.emailcontroller}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool passwordVisible=false;

  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextFormField(
            controller: widget.emailcontroller ,
            decoration: InputDecoration(
              hintText: 'Email',
              fillColor: kSecondaryLightColor,
              filled: true,
              prefixIcon: const Icon(
                Icons.email,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: TextFormField(
            controller: widget.passwordcontroller,
            obscureText: passwordVisible,
            decoration: InputDecoration(
              hintText: 'Password',
              fillColor: kSecondaryLightColor,
              filled: true,
              prefixIcon: const Icon(
                Icons.lock,
                color: kSecondaryColor,
              ),
              suffixIcon: IconButton(
                icon: Icon(passwordVisible
                    ? Icons.visibility_off
                    : Icons.visibility),color: kSecondaryColor,
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
      ],
    );
  }
}
