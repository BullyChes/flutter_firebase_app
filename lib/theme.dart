import 'package:flutter/material.dart';

final theme = ThemeData(
    primaryColorDark: Color(0xff6a3a4f),
    primaryColorLight: Color(0xffdab6c2),
    primaryColor: Color(0xffc77a8c),
    accentColor: Color(0xff9885b2),
    buttonColor: Color(0xff745582),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0), gapPadding: 8.0),
      hintStyle: TextStyle(color: Colors.white),
      labelStyle: TextStyle(color: Colors.white),
      focusColor: Color(0xff6a3a4f),
      filled: true,
      fillColor: Color(0xff6a3a4f),
      // focusedBorder: InputBorder.none,
      contentPadding: const EdgeInsets.all(16.0),
      // enabledBorder: InputBorder.none,
    ));
