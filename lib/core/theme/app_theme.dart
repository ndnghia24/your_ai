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

/// A class to hold the constant colors used in the UI design
class AppColors {
  static const Color primary = Color(0xFFFFFFFF);
  static const Color onPrimary = Color(0xFF00213B);
  static const Color secondary = Color(0xFF0078D4);
  static const Color onSecondary = Color(0xFF00213B);
  static const Color surfaceContainer = Color(0xFFF5F5F5);
  static const Color surfaceDim = Color(0xFF94A3B8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF00213B);
}

/// A class to hold the constant text styles used in the UI design
class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 24.0,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 20.0,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16.0,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14.0,
  );
}
