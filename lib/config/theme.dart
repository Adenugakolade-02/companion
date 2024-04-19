import 'package:caution_companion/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeClass{
  static ThemeData darkTheme = ThemeData();
  static ThemeData lightTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: error400,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontFamily: "Inter", fontSize: 16, fontWeight: FontWeight.w600),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        minimumSize: const Size.fromHeight(55)
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: warning400,
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(fontFamily: "Inter", fontSize: 12, fontWeight: FontWeight.w400)
      )
    )
  );
}