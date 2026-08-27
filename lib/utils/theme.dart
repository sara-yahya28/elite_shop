import 'package:flutter/material.dart';

import '../utils/theme.dart';

const Color primaryColor = Color(0xFF53629E);
const Color secondryColor = Color(0xFF87BAC3);
const Color backgroundColor = Color(0xFFD6F4ED);
const Color textColor = Color(0xFF473472);

// function returns ThemeData
ThemeData appTheme() {
  // contain theme properties
  return ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: 'cairo',

    // appBar styling
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),

    // btn styling
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),

    // input styling
    inputDecorationTheme: InputDecorationTheme(
      filled: true, //allow colored input background
      fillColor: backgroundColor, //input background clr
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: secondryColor),
      ),
      enabledBorder: OutlineInputBorder(
        // field is active
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: secondryColor),
      ),
      focusedBorder: OutlineInputBorder(
        //field when user click
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      labelStyle: const TextStyle(color: textColor),
    ),

    // card styling
    cardTheme: CardThemeData(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),

    // text styling
    textTheme: TextTheme(
      // style for large header
      headlineLarge: const TextStyle( color: textColor, fontWeight: FontWeight.bold),
      bodyLarge:const TextStyle(color: textColor),
      bodySmall: const TextStyle(color: textColor)
    )
  );
}
