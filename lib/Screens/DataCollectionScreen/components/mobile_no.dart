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
  var _phoneNumber = ''; // Store the entered phone number
  bool isPressed = false;

  void _toggledataButtonState() {
    setState(() {
      isPressed = !isPressed;
    });
    print(_phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
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
                        color: kPrimaryLightColor, fontSize: height * 0.065),
                  )),
              const Text(
                "Please enter your valid phone number. We will verify your account. ",
                style: TextStyle(color: Colors.white),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.045),
                  height: height * 0.100,
                  width: double.maxFinite,
                  // decoration: BoxDecoration(
                  //   border: Border.all(width: 1, color: kBrightColor, style: BorderStyle.solid),
                  //   borderRadius: BorderRadius.all(Radius.circular(height*0.025)),           ),
                  child: IntlPhoneField(
                    style: TextStyle(color: Colors.white),
                    dropdownTextStyle: TextStyle(color: kPrimaryLightColor),
                    cursorColor: kPrimaryLightColor,
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(

                      // iconColor:  Colors.white,
                      // fillColor: Colors.white,
                      hintText: '000-000-0000',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      // prefixStyle: TextStyle(
                      //   color: kPrimaryLightColor,
                      // ),
                      // suffixStyle: TextStyle(
                      //   color: kPrimaryLightColor,
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryLightColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryLightColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      prefixIconColor: kPrimaryLightColor,
                      // focusColor: kPrimaryLightColor,
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: kPrimaryLightColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryLightColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  _toggledataButtonState();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.060,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryLightColor,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
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
