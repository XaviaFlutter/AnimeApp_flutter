import 'package:flutter/material.dart';

abstract class AppColor {
  static const Color error = Color(0xffAB3E3E);

  static const darkScheme = ColorScheme.dark(
      primary: Color(0xffF4E7D3),
      secondary: Color(0xffC1876B),
      surface: Color(0xffE05140),
      onSurface: Color(0xff222421),
      error: error);

  static const lightScheme = ColorScheme.light(
      primary: Color(0xffF9C69D),
      secondary: Color(0xffE05140),
      surface: Color(0xffB17457),
      onSurface: Color(0xff222421),
      error: error);
}

class AppTheme {
  static ThemeData darkTheme = ThemeData(
      colorScheme: AppColor.darkScheme,
      scaffoldBackgroundColor: AppColor.darkScheme.onSurface);

  static ThemeData lightTheme = ThemeData(
      colorScheme: AppColor.lightScheme,
      scaffoldBackgroundColor: AppColor.lightScheme.onSurface);
}
