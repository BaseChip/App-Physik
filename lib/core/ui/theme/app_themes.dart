import 'package:flutter/material.dart';

enum AppTheme {
  Dark,
  Dark_Blue,
  Light,
  Amoled_Dark,
}

/// TInspiriert an den Farbpaletten von https://coolors.co/palettes/trending
final appThemeData = {
  ///Material Dark Theme
  AppTheme.Dark: ThemeData(
      scaffoldBackgroundColor: Color.fromRGBO(18, 18, 18, 1),
      fontFamily: "Verdana",
      appBarTheme: AppBarTheme(elevation: 0, color: Colors.transparent),
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
      accentColor: Color.fromRGBO(31, 27, 36, 1),
      dividerColor: Colors.white,
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white),
        headline5: TextStyle(fontSize: 30, color: Colors.white),
        button: TextStyle(color: Colors.white),
      ),
      cardTheme: CardTheme(
          elevation: 5,
          color: Color.fromRGBO(31, 27, 36, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ))),
  AppTheme.Light: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Verdana",
      appBarTheme: AppBarTheme(elevation: 0, color: Colors.transparent),
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
      accentColor: Color.fromRGBO(168, 218, 220, 1),
      dividerColor: Color.fromRGBO(108, 115, 126, 1),
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(color: Color.fromRGBO(108, 115, 126, 1)),
        headline5:
            TextStyle(fontSize: 30, color: Color.fromRGBO(108, 115, 126, 1)),
        headline6: TextStyle(color: Color.fromRGBO(108, 115, 126, 1)),
        button: TextStyle(color: Color.fromRGBO(108, 115, 126, 1)),
      ),
      primaryIconTheme: IconThemeData.fallback().copyWith(color: Colors.black),
      cardTheme: CardTheme(
          elevation: 5,
          color: Color.fromRGBO(168, 218, 220, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ))),
  AppTheme.Amoled_Dark: ThemeData(
      scaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 1),
      fontFamily: "Verdana",
      appBarTheme: AppBarTheme(elevation: 0, color: Colors.transparent),
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
      accentColor: Color.fromRGBO(33, 33, 33, 1),
      dividerColor: Colors.white,
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(color: Color.fromRGBO(232, 236, 241, 1)),
        headline5:
            TextStyle(fontSize: 30, color: Color.fromRGBO(232, 236, 241, 1)),
        button: TextStyle(color: Color.fromRGBO(232, 236, 241, 1)),
      ),
      cardTheme: CardTheme(
          elevation: 5,
          color: Color.fromRGBO(33, 33, 33, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ))),
  AppTheme.Dark_Blue: ThemeData(
      scaffoldBackgroundColor: Color.fromRGBO(38, 70, 83, 1),
      fontFamily: "Verdana",
      appBarTheme: AppBarTheme(elevation: 0, color: Colors.transparent),
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
      accentColor: Color.fromRGBO(42, 157, 143, 1),
      dividerColor: Colors.white,
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(color: Color.fromRGBO(232, 236, 241, 1)),
        headline5:
            TextStyle(fontSize: 30, color: Color.fromRGBO(232, 236, 241, 1)),
        button: TextStyle(color: Colors.white),
      ),
      cardTheme: CardTheme(
          elevation: 5,
          color: Color.fromRGBO(42, 157, 143, 0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ))),
};
