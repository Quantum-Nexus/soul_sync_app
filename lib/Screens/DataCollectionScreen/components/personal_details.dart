import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final _formKey = GlobalKey<FormState>();
  bool isPressed = false;

  void _toggledataButtonState() {
    setState(() {
      if (_convertedHeight != 0 && dobController.text != "") {
        isPressed = !isPressed;
      } else {
        if (dobController.text == "" && _convertedHeight != 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please enter your date of birth."),
              backgroundColor: kPinkColor,
            ),
          );
        } else if (dobController.text != "" && _convertedHeight == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please enter your height."),
              backgroundColor: kPinkColor,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please enter the valid input fields."),
              backgroundColor: kPinkColor,
            ),
          );
        }
      }
    });
    print(_convertedHeight.toInt());
    print(dobController.text);
  }

  String dob = '';
  TextEditingController dobController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }

  String _selectedUnit = 'cm';
  String _inputValue = ''; // The user-entered value
  double _convertedHeight = 0.0; // Height in feet

  void _convertInputToCentimeter() {
    if (_selectedUnit == 'feet') {
      double feet = double.tryParse(_inputValue) ?? 0.0;
      _convertedHeight = feet * 30.48;
      _convertedHeight = double.parse(_convertedHeight.toStringAsFixed(1));
    } else if (_selectedUnit == 'cm') {
      _convertedHeight = double.tryParse(_inputValue) ?? 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset:
          false,
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
          width: width,
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: height * 0.065,
              ),
              Container(
                width: width,
                height: height * 0.200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                          text: 'Age is just a number ',
                          style: GoogleFonts.urbanist(
                              fontSize: height * 0.0435,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryLightColor),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'and we want ',
                              style: GoogleFonts.urbanist(
                                fontSize: height * 0.0435,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryLightColor,
                              ),
                            ),
                            TextSpan(
                              text: 'YOURS',
                              style: GoogleFonts.urbanist(
                                fontSize: height * 0.0435,
                                fontWeight: FontWeight.bold,
                                color: kPinkColor,
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  height: height * 0.180,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AbsorbPointer(
                          absorbing: false,
                          child: TextFormField(
                            onTap: () async {
                              //_selectDate(context);
                              String formattedDate = "";
                              final DateTime? picked = await showDatePicker(
                                barrierColor: kPrimaryColor,
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2025),
                              );
                              if (picked != null && picked != DateTime.now()) {
                                setState(() {
                                  dobController.text =
                                      DateFormat('dd-MM-yyyy').format(picked);
                                });
                                // initState();
                              }
                            },
                            controller: dobController,
                            cursorColor: kPrimaryColor,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Date of Birth',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 0.25),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryLightColor, width: 0.25),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          cursorColor: kPrimaryLightColor,
                          style: const TextStyle(color: kPrimaryLightColor),
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryLightColor, width: 0.25),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: '000(in cm) & 0.0 (in feet)',
                            hintStyle: const TextStyle(color: Colors.white54),
                            border: const OutlineInputBorder(),
                            labelText: 'Height',
                            labelStyle: const TextStyle(
                                color: kPrimaryLightColor), // Hint text color
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: kPrimaryLightColor, width: 0.25),
                              // Border color
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                focusColor: kPrimaryLightColor,
                                iconEnabledColor: kPrimaryLightColor,
                                value: _selectedUnit,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedUnit = newValue!;
                                    _inputValue =
                                        ''; // Reset the input value when unit changes
                                  });
                                },
                                items: <String>['cm', 'feet'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                        color: Colors.white, // Text color
                                      ),
                                    ),
                                  );
                                }).toList(),
                                underline: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ), // Remove the underline
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white, // Icon color
                                ),
                                dropdownColor: kPrimaryColor,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _inputValue = value;
                              _convertInputToCentimeter();
                            });
                          },
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  _toggledataButtonState();
                  if (isPressed == true) {
                    Navigator.pushNamed(context, '/aboutme');
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
      ),
    );
  }
}
