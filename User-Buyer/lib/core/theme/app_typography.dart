import 'package:flutter/material.dart';

/// ZRent Buyer App Typography
/// 
/// Font family: Inter (Google Fonts)
class AppTypography {
  static const String fontFamily = 'Inter';
  
  // Font Sizes
  static const double fontSize10 = 10.0;
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize24 = 24.0;
  static const double fontSize28 = 28.0;
  static const double fontSize32 = 32.0;
  
  // Font Weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  
  // Text Styles
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize32,
    fontWeight: bold,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize28,
    fontWeight: bold,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize24,
    fontWeight: bold,
    height: 1.3,
    letterSpacing: -0.3,
  );
  
  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize20,
    fontWeight: semiBold,
    height: 1.3,
    letterSpacing: -0.2,
  );
  
  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize18,
    fontWeight: semiBold,
    height: 1.4,
    letterSpacing: -0.2,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize16,
    fontWeight: regular,
    height: 1.5,
    letterSpacing: 0,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize14,
    fontWeight: regular,
    height: 1.5,
    letterSpacing: 0,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize12,
    fontWeight: regular,
    height: 1.4,
    letterSpacing: 0.1,
  );
  
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize14,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.1,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize12,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.2,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize10,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.3,
  );
}
