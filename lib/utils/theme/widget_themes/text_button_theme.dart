import 'package:ecommerce_user/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TTextButtonTheme {
  TTextButtonTheme._();

  static final lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.buttonPrimary,

      // : TColors.white,
      shadowColor: TColors.white,
      textStyle: const TextStyle(
          fontSize: 16,
          color: TColors.buttonPrimary,
          fontWeight: FontWeight.w600),
    ),
  );

  static final darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.buttonPrimary,

      // : TColors.white,
      shadowColor: TColors.white,
      textStyle: const TextStyle(
          fontSize: 16,
          color: TColors.buttonPrimary,
          fontWeight: FontWeight.w600),
    ),
  );
}
