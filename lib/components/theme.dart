import 'package:flutter/material.dart';

ThemeData get appTheme {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    buttonColor: Colors.transparent,
    splashColor: Colors.transparent,
    accentColor: Colors.white,
    textSelectionColor: Colors.blueGrey,
    textTheme: TextTheme(
      button: TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontSize: 20,
        fontFamily: "Roboto",
      ),
      headline: TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontSize: 26,
        fontFamily: "Roboto",
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
