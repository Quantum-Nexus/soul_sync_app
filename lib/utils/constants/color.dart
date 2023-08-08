import 'package:flutter/material.dart';

//--------------------C O L O R S--------------------

// This function is used to generate a MaterialColor from a Color
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
    getMaterialColor(const Color.fromARGB(255, 11, 116, 202));


// This is the primary color of the application
const Color kPrimaryColor = Color(0xFF0D47A1);
const Color kPrimaryLightColor = Color(0xFFE3F2FD);

// This is the secondary color of the application
const Color kSecondaryColor = Color(0xFFBDBDBD);
const Color kSecondaryLightColor = Color(0xFFE0E0E0);

// This is the background color of the application
const Color kBackgroundColor = Color(0xFFFFFFFF);  

// This is the text color of the application
const Color kTextColor = Color(0xFF000000);  
const Color kTextLightColor = Color(0xFF757575);

// This is the shadow color of the application
const Color kShadowColor = Color(0xFFE6E6E6);  

// This is the button color of the application
const Color kButtonColor = Color(0xFF5097DA);   

// This is the transparent color of the application
const Color kTransparentColor = Color(0x00000000);  

// This is the info color of the application
const Color kInfoColor = Color(0xFF2196F3);

// This is the dark color of the application for text and buttons
const Color kDarkColor = Color(0xFF000000);   

// This is the light color of the application for text 
const Color kLightColor = Color(0xFFFFFFFF);   

// This is the grey color of the application for  text
const Color kGreyColor = Color(0xFF9E9E9E);   

// This is the dark grey color of the application
const Color kDarkGreyColor = Color(0xFF424242);

// This is red color for text in the application for text and button 
const Color kRedTextColor = Color(0xFFCB2C3D);   

// This is the success, error & warning color of the application
// success: green
const Color kSuccessColor = Color(0xFF4CAF50);
// error: red
const Color kErrorColor = Color(0xFFB00020);
// warning: yellow
const Color kWarningColor = Color(0xFFFFC107);

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
LinearGradient kSplashGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    const Color(0xFF42A5F5).withOpacity(0.2),
    const Color(0xFF42A5F5).withOpacity(0.2),
    const Color(0xFF42A5F5).withOpacity(0.1),
    Colors.white.withOpacity(0.1),
  ],
);

// This is the secondary gradient color of the application
const LinearGradient kSecondaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFBDBDBD),
    Color(0xFFE0E0E0),
    Color(0xFFEEEEEE),
  ],
);

// This is the background gradient color of the application
const LinearGradient kBackgroundGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFFAFAFA),
    Color(0xFFF5F5F5),
    Color(0xFFEEEEEE),
  ],
);

// This is the text gradient color of the application
const LinearGradient kTextGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF000000),
    Color(0xFF424242),
    Color(0xFF616161),
  ],
);

// This is the shadow gradient color of the application
const LinearGradient kShadowGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFE6E6E6),
    Color(0xFFBDBDBD),
    Color(0xFF9E9E9E),
  ],
);

// This is the success gradient color of the application
const LinearGradient kSuccessGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF4CAF50),
    Color(0xFF66BB6A),
    Color(0xFF81C784),
  ],
);

// This is the error gradient color of the application
const LinearGradient kErrorGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFB00020),
    Color(0xFFC62828),
    Color(0xFFD32F2F),
  ],
);

// This is the warning gradient color of the application
const LinearGradient kWarningGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFFFC107),
    Color(0xFFFFD54F),
    Color(0xFFFFE082),
  ],
);


LinearGradient kBottomGradientColor = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    Color(0xFF0097DA),
    Color(0xFF0097DA).withOpacity(0.4),
    Color(0xFFffffff).withOpacity(0.1),
  ],
);