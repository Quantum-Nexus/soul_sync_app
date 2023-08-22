import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

class GenderInfo extends StatefulWidget {
  const GenderInfo({super.key});

  @override
  State<GenderInfo> createState() => _GenderInfoState();
}

class _GenderInfoState extends State<GenderInfo> {
  // bool isTapped = false;

  // void _handleTap() {
  //   setState(() {
  //     isTapped = !isTapped;
  //   });
  // }
  bool manTapped = false;
  bool womanTapped = false;
  bool otherTapped = false;

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
      backgroundColor: kPrimaryColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //column elsement 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  color: kBrightColor,
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                Text(
                  'Skip',
                  style:
                      TextStyle(color: kBrightColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
            // SizedBox(
            //   height: height * 0.033,
            // ),
            Text(
              "I am",
              style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.bold,
                  color: kBrightColor,
                  fontSize: height * 0.065),
            ),
            // SizedBox(
            //   height: height * 0.053,
            // ),
            // Container(
            //   height: height * 0.195,
            //   // decoration: BoxDecoration(
            //   //   border: Border.all(color: Colors.blue,)
            //   // ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       GestureDetector(
            //         onTap: _handleTap,
            //         child: Container(
            //           padding: const EdgeInsets.all(12),
            //           width: double.maxFinite,
            //           //height: 0.045,
            //           decoration: BoxDecoration(
            //               color: isTapped ? Colors.red : Colors.transparent,
            //               border: Border.all(
            //                   color: isTapped ? Colors.red : Colors.grey,
            //                   width: 2),
            //               borderRadius: BorderRadius.circular(5)),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 'Man',
            //                 style: GoogleFonts.urbanist(
            //                     color: isTapped ? Colors.white : Colors.black,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //               Icon(isTapped? Icons.check: Icons.arrow_right, color: isTapped ? Colors.white : Colors.black,),
            //             ],
            //           ),
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: _handleTap,
            //         child: Container(
            //           padding: const EdgeInsets.all(12),
            //           width: double.maxFinite,
            //           //height: 0.045,
            //           decoration: BoxDecoration(
            //               color: isTapped ? Colors.red : Colors.transparent,
            //               border: Border.all(
            //                   color: isTapped ? Colors.red : Colors.grey,
            //                   width: 2),
            //               borderRadius: BorderRadius.circular(5)),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 'Woman',
            //                 style: GoogleFonts.urbanist(
            //                     color: isTapped ? Colors.white : Colors.black,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //             Icon(isTapped? Icons.check: Icons.arrow_right, color: isTapped ? Colors.white : Colors.black,),

            //             ],
            //           ),
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: _handleTap,
            //         child: Container(
            //           padding: const EdgeInsets.all(12),
            //           width: double.maxFinite,
            //           //height: 0.045,
            //           decoration: BoxDecoration(
            //               color: isTapped ? Colors.red : Colors.transparent,
            //               border: Border.all(
            //                   color: isTapped ? Colors.red : Colors.grey,
            //                   width: 2),
            //               borderRadius: BorderRadius.circular(5)),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 'Other',
            //                 style: GoogleFonts.urbanist(
            //                     color: isTapped ? Colors.white : Colors.black,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //               Icon(isTapped? Icons.check: Icons.arrow_right, color: isTapped ? Colors.white : Colors.black,),

            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              height: height * 0.225,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OptionItem(
                    label: 'Man',
                    isTapped: manTapped,
                    onTap: () {
                      setState(() {
                        manTapped = !manTapped;
                      });
                    },
                  ),
                  OptionItem(
                    label: 'Woman',
                    isTapped: womanTapped,
                    onTap: () {
                      setState(() {
                        womanTapped = !womanTapped;
                      });
                    },
                  ),
                  OptionItem(
                    label: 'Other',
                    isTapped: otherTapped,
                    onTap: () {
                      setState(() {
                        otherTapped = !otherTapped;
                      });
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _toggleButtonState();
              },
              child: Container(
                alignment: Alignment.center,
                height: height * 0.060,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: isPressed ? Colors.white : kBrightColor,
                  border: Border.all(color: isPressed ?   kBrightColor : Colors.transparent, width: 1),
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
          color: isTapped ? Color.fromRGBO(233, 64, 87, 1) : Colors.transparent,
          border:
              Border.all(color: isTapped ? Color.fromRGBO(26, 31, 43, 1) : Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.urbanist(
                color: isTapped ? Colors.white : kBrightColor,
                fontWeight: FontWeight.bold,
                fontSize: height * 0.0175,
              ),
            ),
            Icon(
              isTapped ? Icons.check : Icons.arrow_right,
              color: isTapped ? Colors.white : kBrightColor,
            ),
          ],
        ),
      ),
    );
  }
}
