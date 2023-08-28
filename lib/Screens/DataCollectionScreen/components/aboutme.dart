import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({super.key});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  final _formKey = GlobalKey<FormState>();

  String _dob = '';
  String _height = '';
  String _instagramId = '';
  String _graduationYear = '';
  String _about = '';
  bool isPressed = false;

  void _toggledataButtonState() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height * 0.12,
              decoration: BoxDecoration(
                  // border: Border.all(
                  //     color: Colors.red, width: 1, style: BorderStyle.solid),
                  ),
              child: Text(
                'Transform Your College Story Today!',
                style: GoogleFonts.quicksand(
                    color: kPrimaryLightColor,
                    fontSize: height * 0.0385,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: height * 0.65,
              decoration: BoxDecoration(
                  // border: Border.all(
                  //     color: Colors.red, width: 1, style: BorderStyle.solid),
                  ),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        cursorColor: kPrimaryLightColor,
                        style: TextStyle(color: kPrimaryLightColor),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryLightColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Date of Birth',
                          labelStyle: TextStyle(
                              color: kPrimaryLightColor), // Hint text color
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: kPrimaryLightColor,
                                ),
                          ),
                        ),
                        onChanged: (value) {
                          _dob = value;
                        },
                      ),
                      TextFormField(
                        cursorColor: kPrimaryLightColor,
                        style: TextStyle(color: kPrimaryLightColor),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryLightColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Height',
                          labelStyle: TextStyle(
                              color: kPrimaryLightColor), // Hint text color
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: kPrimaryLightColor), // Border color
                          ),
                        ),
                        onChanged: (value) {
                          _height = value;
                        },
                      ),
                      TextFormField(
                        cursorColor: kPrimaryLightColor,
                        style: TextStyle(color: kPrimaryLightColor),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryLightColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Instagram ID',
                          labelStyle: TextStyle(
                              color: kPrimaryLightColor), // Hint text color
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: kPrimaryLightColor), // Border color
                          ),
                        ),
                        onChanged: (value) {
                          _instagramId = value;
                        },
                      ),
                      TextFormField(
                        cursorColor: kPrimaryLightColor,
                        style: TextStyle(color: kPrimaryLightColor),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryLightColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Graduation Year',
                          labelStyle: TextStyle(
                              color: kPrimaryLightColor), // Hint text color
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: kPrimaryLightColor), // Border color
                          ),
                        ),
                        onChanged: (value) {
                          _graduationYear = value;
                        },
                      ),
                      TextFormField(
                        cursorColor: kPrimaryLightColor,
                        style: TextStyle(color: kPrimaryLightColor),
                        maxLines: 5,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryLightColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'About',
                          hintMaxLines: 5,
                          labelStyle: TextStyle(
                              color: kPrimaryLightColor), // Hint text color
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: kPrimaryLightColor), // Border color
                          ),
                        ),
                        onChanged: (value) {
                          _about = value;
                        },
                      ),
                    ]),
              ),
            ),
            Container(
              height: height * 0.060,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      _toggledataButtonState();
                      if (isPressed == true) {
                        Navigator.pushNamed(context, '');
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.060,
                      // width: double.maxFinite,
                      decoration: BoxDecoration(
                        // border: Border.all(
                        // color: Colors.red, width: 1, style: BorderStyle.solid),
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
          ],
        ),
      ),
    );
  }
}
