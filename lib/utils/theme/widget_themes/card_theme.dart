import 'package:ecommerce_user/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TCardTheme {
  TCardTheme._();

  /* -- Light Theme -- */
  static const lightCardTheme =
      CardTheme(color: TColors.lightPurple, elevation: 10);

  /* -- Dark Theme -- */
  static const darkCardTheme = CardTheme(color: TColors.black, elevation: 10);
}
