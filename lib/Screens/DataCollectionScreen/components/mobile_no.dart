import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

class MobileNo extends StatefulWidget {
  const MobileNo({super.key});

  @override
  State<MobileNo> createState() => _MobileNoState();
}

class _MobileNoState extends State<MobileNo> {
  TextEditingController _phoneNumberController = TextEditingController();
  String _phoneNumber = ''; // Store the entered phone number
  bool isPressed = false;

  void _toggleButtonState() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.120,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.0045),
                  child: Text(
                    "My Mobile",
                    style: GoogleFonts.urbanist(
                        color: kBrightColor, fontSize: height * 0.065),
                  )),
              Text(
                "Please enter your valid phone number. We will send you a 4-digit code to verify your account. ",
                style: TextStyle(color: Colors.black),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.045),
                  height: height * 0.100,
                  width: double.maxFinite,
                  // decoration: BoxDecoration(
                  //   border: Border.all(width: 1, color: kBrightColor, style: BorderStyle.solid),
                  //   borderRadius: BorderRadius.all(Radius.circular(height*0.025)),           ),
                  child: IntlPhoneField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
        
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                     setState(() {
                      _phoneNumber = phone.completeNumber;
                    });
                    },
                  )),
              SizedBox(
                height: height * 0.3200,
              ),
              GestureDetector(
                onTap: () {
                  _toggleButtonState();
                  String phoneNumber = _phoneNumberController.text;
                  // You can handle the phone number here
                  print('Phone Number: $phoneNumber');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.060,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isPressed ? Colors.white : kBrightColor,
                    border: Border.all(
                        color: isPressed ? kBrightColor : Colors.transparent,
                        width: 1),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        color: isPressed ? kBrightColor : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
