import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: height * 0.325,
            margin: EdgeInsets.symmetric(vertical: height * 0.045),
            child: Lottie.asset(
              'assets/images/onboard.json',
              fit: BoxFit.cover,
              reverse: true,
              repeat: true,
            ),
          ),
          Text.rich(
            TextSpan(
                text: 'Welcome to\n',
                style: GoogleFonts.raleway(
                    fontSize: height * 0.0425,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryLightColor),
                children: <InlineSpan>[
                  TextSpan(
                      text: 'Soul Sync',
                      style: GoogleFonts.raleway(
                          //fontFamily: 'Oswald',
                          fontSize: height * 0.0425,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 117, 194, 233)))
                ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.0225),
            child: Text(
              'Connecting Hearts, One Swipe at a Time - Discover Meaningful Connections on our Dating App',
              style: TextStyle(
                color: kPrimaryLightColor,
                fontSize: height * 0.0185,
              ),
            ),
          ),
          //SizedBox(height: height*0.06,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.04),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: Container(
                height: height * 0.0550,
                width: double.maxFinite,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 117, 194, 233),
                    borderRadius: BorderRadius.circular(25)),
                child: Text(
                  'Join now',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.0185),
                ),
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
                style: TextStyle(
                    fontSize: height * 0.0185, color: kPrimaryLightColor),
              )))
        ],
      ),
    );
  }
}
