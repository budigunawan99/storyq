import 'package:flutter/widgets.dart';

class StoryqTextStyle {
  static const TextStyle _poppins = TextStyle(fontFamily: "Poppins");

  static TextStyle displayLarge = _poppins.copyWith(
    fontSize: 55,
    fontWeight: FontWeight.w700,
    height: 1.10,
    letterSpacing: -1,
  );

  static TextStyle displayMedium = _poppins.copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w600,
    height: 1.15,
    letterSpacing: -1,
  );

  static TextStyle displaySmall = _poppins.copyWith(
    fontSize: 35,
    fontWeight: FontWeight.w500,
    height: 1.25,
    letterSpacing: -1,
  );

  static TextStyle headlineLarge = _poppins.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: -1,
  );

  static TextStyle headlineMedium = _poppins.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.25,
    letterSpacing: -1,
  );

  static TextStyle headlineSmall = _poppins.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: -1,
  );

  static TextStyle titleLarge = _poppins.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 1.0,
  );

  static TextStyle titleMedium = _poppins.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: 1.0,
  );

  static TextStyle titleSmall = _poppins.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.2,
    letterSpacing: 1.0,
  );

  static TextStyle bodyLargeBold = _poppins.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.55,
  );

  static TextStyle bodyLargeMedium = _poppins.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.55,
  );

  static TextStyle bodyLargeRegular = _poppins.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    height: 1.55,
  );

  static TextStyle labelLarge = _poppins.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.6,
    letterSpacing: 1.25,
  );

  static TextStyle labelMedium = _poppins.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    height: 1.4,
    letterSpacing: 1.25,
  );

  static TextStyle labelSmall = _poppins.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w300,
    height: 1.2,
    letterSpacing: 1.25,
  );
}
