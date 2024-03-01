import 'package:flutter/material.dart';

final class LabClinicaTheme {
  static const orangeColor = Color(0xFFFFAE45);
  static const lightOrangeColor = Color(0xFFFFEFE9);
  static const blueColor = Color(0xFF01BDD6);
  static const lightGrey = Color(0xFFFFEFE9);
  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: lightOrangeColor),
  );

  static final lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: lightOrangeColor),
      useMaterial3: true,
      fontFamily: 'Montserrat',
      scaffoldBackgroundColor: lightOrangeColor,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightOrangeColor,
        labelStyle: const TextStyle(
          fontSize: 14,
          color: orangeColor,
          fontWeight: FontWeight.w700,
        ),
        floatingLabelStyle: const TextStyle(
          color: blueColor,
          fontWeight: FontWeight.w600,
        ),
        border: _defaultInputBorder,
        enabledBorder: _defaultInputBorder,
        focusedBorder: _defaultInputBorder,
        errorBorder: _defaultInputBorder.copyWith(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: blueColor),
            foregroundColor: blueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            )),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: blueColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ));
  static final darkTheme = lightTheme;

  static const titleStyle = TextStyle(
    color: blueColor,
    fontSize: 32,
    fontWeight: FontWeight.w900,
  );
  static const titleSmallStyle = TextStyle(
    color: blueColor,
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );
  static const subTitleStyle = TextStyle(
    color: blueColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
}
