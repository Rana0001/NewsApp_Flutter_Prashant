import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeConfig {
  static ThemeData getLightThemeData() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );
  }

  static ThemeData getDarkThemeData() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: GoogleFonts.poppins().fontFamily ?? '',
      brightness: Brightness.dark,
    );
  }
}
