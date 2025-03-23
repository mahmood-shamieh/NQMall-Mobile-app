import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static const Color mainColor = Color(0xffD5955D);
  static const Color secondaryColor = Color(0xff808080);
  static const Color shadowColor = Color.fromARGB(255, 172, 172, 172);
  static const Color textColor = Color(0xff000000);
  static const Color whiteColor = Color(0xffffffff);
  static const Color textColorLight = Color(0xffA0A4AB);
  static const Color buttonColor = Color(0xffD5955D);
  static const Color offWhiteColor = Color.fromARGB(255, 255, 255, 255);
  static const double buttonsRadius = 12.0;
  static const double buttonsFontSize = 12.0;

  static getButtonStyle(
      {final Color? color,
      final FontWeight? fontWeight,
      final double? fontSize}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
          color: color ?? whiteColor,
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: fontSize ?? buttonsFontSize),
    );
  }
}
