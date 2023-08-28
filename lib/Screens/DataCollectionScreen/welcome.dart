import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:soul_sync_app/utils/constants/color.dart";

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        alignment: Alignment.center,
        width: width,
        // decoration: BoxDecoration(
        //   border: Border.all(
        //       width: 1, color: kBrightColor, style: BorderStyle.solid),
        // ),
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Container(
          width: width,
          height: height * 0.300,
          // decoration: BoxDecoration(
          //   border: Border.all(
          //       width: 1, color: kBrightColor, style: BorderStyle.solid),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                    text: 'Welcome to\n',
                    style: GoogleFonts.quicksand(
                        fontSize: height * 0.0625,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryLightColor),
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Soul ',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: height * 0.0625,
                          fontWeight: FontWeight.bold,
                          color: kYellowColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Sync',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: height * 0.0625,
                          fontWeight: FontWeight.bold,
                          color: kPinkColor,
                        ),
                      ),
                    ]),
              ),
              Text(
                'Just a few steps away 🥰',
                style: GoogleFonts.quicksand(
                  fontSize: height * 0.0325,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryLightColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
