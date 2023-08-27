import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: width,
            height: height * 0.50,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: height * 0.025),
            decoration: BoxDecoration(
                // border: Border.all(
                //     color: Colors.red, width: 1, style: BorderStyle.solid),
                ),
            child: Image.asset(
              width: double.maxFinite,
              fit: BoxFit.fitWidth,
              'assets/images/onboard.png',
            )),
        Container(
          height: height * 0.400,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 50),
          decoration: BoxDecoration(
            // border: Border.all(
            //     color: Colors.red, width: 3, style: BorderStyle.solid),
          ),
          // margin: const EdgeInsets.all(15),
          // padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  // border: Border.all(
                  //     color: Colors.red, width: 3, style: BorderStyle.solid),
                ),
                height: height * 0.21,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                          text: 'Dive into the\n',
                          style: GoogleFonts.quicksand(
                              fontSize: height * 0.0415,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryLightColor),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Soul ',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: height * 0.0415,
                                fontWeight: FontWeight.bold,
                                color: kYellowColor,
                              ),
                            ),
                            TextSpan(
                              text: 'Sync ',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: height * 0.0415,
                                fontWeight: FontWeight.bold,
                                color: kPinkColor,
                              ),
                            ),
                            TextSpan(
                              text: 'Experience',
                              style: GoogleFonts.quicksand(
                                fontSize: height * 0.0415,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryLightColor,
                              ),
                            )
                          ]),
                    ),
                    Text(
                      'For Campus Hearts to Connect. Swipe, Match, Chat – Ignite Connections that Define Your College Journey. Feel the Vibes!',
                      style: GoogleFonts.quicksand(
                        color: kPrimaryLightColor,
                        fontSize: height * 0.0175,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 3, style: BorderStyle.solid),),
                height: 0.1*height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: Container(
                          height: height * 0.06,
                          width: double.maxFinite,
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              color: kPinkColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Join now',
                            style: GoogleFonts.quicksand(
                                color: kPrimaryLightColor,
                                fontWeight: FontWeight.bold,
                                fontSize: height * 0.0185),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Center(
                            child: Text(
                          'Already a member? Log in',
                          style: GoogleFonts.quicksand(
                              fontSize: height * 0.0165,
                              color: kPrimaryLightColor),
                        )),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
