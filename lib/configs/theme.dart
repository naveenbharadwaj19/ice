import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  primaryColor: const Color(0xfff5f5f4),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.white,
    tertiary: const Color(0xffe9e6ec),
    surface: const Color(0xff2646eb),
    background: const Color(0xff292929),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xff2646eb)),
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: Color(0xff292929), fontSize: 28),
    headlineMedium: TextStyle(color: Color(0xff292929), fontSize: 24),
    headlineSmall: TextStyle(color: Color(0xff292929), fontSize: 22),
    bodyLarge: TextStyle(color: Color(0xff292929), fontSize: 18),
    bodyMedium: TextStyle(color: Color(0xff292929), fontSize: 16),
    bodySmall: TextStyle(color: Color(0xff292929), fontSize: 14),
  ),
  fontFamily: "Oxygen",
);
