import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}

// This is the primary swatch of the application
MaterialColor kPrimarySwatch =
    getMaterialColor(const Color.fromARGB(255, 39, 55, 77));

//--------------------C O L O R S--------------------

const Color kPrimaryColor = Color.fromRGBO(26, 31, 43, 1);
const Color kPrimaryLightColor = Color(0xffDDE6ED);

// This is the secondary color of the application
const Color kSecondaryColor = Color(0xff526D82);
const Color kSecondaryLightColor = Color(0xff9DB2BF);

// This is the background color of the application
const Color kBackgroundColor = kPrimaryColor;

// This is the text color of the application
const Color kTextColor = Colors.white;  

const Color kBrightColor = Color.fromRGBO(233, 64, 87, 1);

// ------------------G R A D I E N T S------------------
// This is the primary gradient color of the application
const LinearGradient kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF0D47A1),
    Color(0xFF1976D2),
    Color(0xFF42A5F5),
  ],
);

//--------------------------S T Y L E S-----------------------

TextStyle kHeadingStyle = GoogleFonts.playfairDisplay(
     fontSize:24,
     fontWeight: FontWeight.w800
);

TextStyle kDescriptionStyle = GoogleFonts.inconsolata(
    fontSize:24,
    fontWeight: FontWeight.w800
);

TextStyle kLogoStyle = GoogleFonts.lobster(
    fontSize:52,
    fontWeight: FontWeight.w600,
  color: kSecondaryLightColor

);
