import 'package:flutter/material.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (index) => FocusNode());
    _controllers = List.generate(6, (index) => TextEditingController());
  }

  void onDigitEntered(int index, String value) {
    if (value.length > 1) {
      value = value.substring(0, 1); // Only take the first character
    }

    _controllers[index].text = value;

    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  Widget buildDigitInput(int index) {
    return Container(
      width: 50,
      height: 55,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: _focusNodes[index].hasFocus ? Color.fromARGB(255, 117, 194, 233): kSecondaryLightColor,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        onChanged: (value) => onDigitEntered(index, value),
        decoration: InputDecoration(
          counterText: '', // Hide the character count
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 117, 194, 233),width: 2.0) ),
          disabledBorder: InputBorder.none
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the OTP sent to your email',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < _controllers.length; i++)
                  buildDigitInput(i),
              ],
            ),
            SizedBox(height: 20),
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2.0, color: kPrimaryLightColor),
                    ),
                child: const Text(
                  'Verify OTP',
                  style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}






