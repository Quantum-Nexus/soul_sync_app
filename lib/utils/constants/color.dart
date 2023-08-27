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

const Color kPrimaryColor = Colors.black;
//Color.fromRGBO(26, 31, 43, 1);
const Color kPrimaryLightColor = Color(0xffDDE6ED);

// This is the secondary color of the application
const Color kSecondaryColor = Color(0xff526D82);
const Color kSecondaryLightColor = Color(0xff9DB2BF);

// This is the background color of the application
const Color kBackgroundColor = kPrimaryColor;

const Color kYellowColor = Color(0xffFFF100);


const Color kPinkColor = Color(0xffFF2093);

const Color kGreyColor = Color.fromARGB(255, 31, 31, 31);

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

TextStyle kLogo1Style = GoogleFonts.leagueSpartan(
    fontSize:64,
    fontWeight: FontWeight.w800,
  color: kYellowColor

);

TextStyle kLogo2Style = GoogleFonts.leagueSpartan(
    fontSize:64,
    fontWeight: FontWeight.w800,
  color: kPinkColor

);

TextStyle kTagStyle = GoogleFonts.quicksand(
    fontSize:13,
    letterSpacing: 9,
    fontWeight: FontWeight.w600,
    color: Colors.white

);

TextStyle kAppbarStyle = GoogleFonts.leagueSpartan(
    fontSize:16,
    fontWeight: FontWeight.w800,
  color: kPinkColor

);


TextStyle kNameStyle = GoogleFonts.roboto(
    fontSize:50,
    fontWeight: FontWeight.w500,
  color: Colors.white

);
TextStyle kHeadStyle = GoogleFonts.quicksand(
    fontSize:24,
    fontWeight: FontWeight.w600,
  color: Colors.white70

);
TextStyle kLeadingStyle = GoogleFonts.roboto(
    fontSize:16,
    fontWeight: FontWeight.w500,
  color: Colors.white

);
TextStyle kAboutStyle = GoogleFonts.roboto(
    fontSize:20,
    fontWeight: FontWeight.w500,
  color: Colors.white

);

TextStyle kWelcomeStyle = GoogleFonts.barlow(
    fontSize: 33,
    fontWeight: FontWeight.w800,
  color: Colors.white

);

// ---------------- PROFILESCREEN STYLES -----------------

TextStyle kDetailHeadStyle = GoogleFonts.barlow(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  color: Colors.white38
);

TextStyle kDetailStyle = GoogleFonts.barlow(
  height: 1.2,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  color: Colors.white
);