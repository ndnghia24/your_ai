import 'package:flutter/material.dart';

/// A class to hold the constant ...
class ThemeConfig {
  static ThemeData lightMode = ThemeData(
      fontFamily: 'SanFrancisco',
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        background: Colors.grey.shade200,
        primary: Colors.grey.shade300,
        secondary: Colors.grey.shade400,
      ));

  static ThemeData darkMode = ThemeData(
      fontFamily: 'SanFrancisco',
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        background: Colors.grey.shade900,
        primary: Colors.grey.shade800,
        secondary: Colors.grey.shade700,
      ));
}
