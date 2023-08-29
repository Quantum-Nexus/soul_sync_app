import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

class GenderInfo extends StatefulWidget {
  const GenderInfo({super.key});

  @override
  State<GenderInfo> createState() => _GenderInfoState();
}

class _GenderInfoState extends State<GenderInfo> {
  String selectedOption = ''; // Add this line
  void _toggleButtonState(String option) {
    // Modify the method signature
    setState(() {
      selectedOption = option;
    });
    print(selectedOption);
  }

  bool isPressed = false;

  void _toggledataButtonState() {
    setState(() {
      if (selectedOption == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please specify your gender."),backgroundColor: kPinkColor),
        );
        return;
      } else {
        isPressed = !isPressed;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.012,
            ),
            //column elsement 1
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     IconButton(
            //       padding: EdgeInsets.zero,
            //       constraints: BoxConstraints(),
            //       color: kPinkColor,
            //       onPressed: () {},
            //       icon: Icon(Icons.arrow_back_ios_new),
            //     ),
            //     Text(
            //       'Skip',
            //       style: TextStyle(
            //           color: kPinkColor, fontWeight: FontWeight.bold),
            //     )
            //   ],
            // ),
            Text(
              "I am",
              style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: height * 0.065),
            ),
            Container(
              height: height * 0.225,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OptionItem(
                    label: 'Man',
                    isTapped: selectedOption == "Male",
                    onTap: () {
                      _toggleButtonState('Male');
                    },
                  ),
                  OptionItem(
                    label: 'Woman',
                    isTapped: selectedOption == "Female",
                    onTap: () {
                      _toggleButtonState('Female');
                    },
                  ),
                  OptionItem(
                    label: 'Other',
                    isTapped: selectedOption == "Others",
                    onTap: () {
                      _toggleButtonState('Others');
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.150,
            ),
            GestureDetector(
              onTap: () {
                _toggledataButtonState();
                if (isPressed == true) {
                  Navigator.pushNamed(context, '/personaldetails');
                }
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
    );
  }
}

class OptionItem extends StatelessWidget {
  final String label;
  final bool isTapped;
  final VoidCallback onTap;

  const OptionItem({
    super.key,
    required this.label,
    required this.isTapped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(height * 0.0155),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: isTapped ? kPinkColor : Colors.transparent,
          border: Border.all(
              color: isTapped ? kPinkColor : Colors.white, width: 0.25),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: height * 0.0175,
              ),
            ),
            Icon(
              isTapped ? Icons.check : null,
              color: isTapped ? Colors.white : null,
            ),
          ],
        ),
      ),
    );
  }
}
