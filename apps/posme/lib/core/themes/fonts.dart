import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orkitt/orkitt.dart';

class AppFonts extends BrandTypo {
  @override
  String get fontFamily => GoogleFonts.inter().fontFamily!;

  // Body text
  @override
  TextStyle get bodyLarge =>
      GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w400);

  @override
  TextStyle get bodyMedium =>
      GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w400);

  @override
  TextStyle get bodySmall =>
      GoogleFonts.inter(fontSize: 10.sp, fontWeight: FontWeight.w400);

  // Display / Headline
  @override
  TextStyle get displayLarge =>
      GoogleFonts.inter(fontSize: 32.sp, fontWeight: FontWeight.w700);

  @override
  TextStyle get displayMedium =>
      GoogleFonts.inter(fontSize: 28.sp, fontWeight: FontWeight.w600);


  // Titles
  @override
  TextStyle get titleLarge =>
      GoogleFonts.inter(fontSize: 22.sp, fontWeight: FontWeight.w700);

  @override
  TextStyle get titleMedium =>
      GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.w600);

  @override
  TextStyle get titleSmall =>
      GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w600);

  // Labels / Buttons
  @override
  TextStyle get labelLarge =>
      GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w500);

  @override
  TextStyle get labelMedium =>
      GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500);

  @override
  TextStyle get labelSmall =>
      GoogleFonts.inter(fontSize: 8.sp, fontWeight: FontWeight.w500);
}
