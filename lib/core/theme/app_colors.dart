import 'package:flutter/material.dart';

/// A class to hold the constant colors used in the UI design
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF64b334); // Màu chính
  static const Color primaryVariant = Color(0xFF236823);

  // Secondary Colors
  static const Color secondary = Color(0xFF1f6fa4); // Màu phụ
  static const Color secondaryVariant = Color(0xFF246f75);
  static const Color secondaryLight = Color(0xFF0098F3);

  // Background and Surface
  static const Color background = Color(0xFFFCFCFC); // Màu nền
  static const Color surface = Color(0xFFEEEFF5); // Màu bề mặt

  // Text Colors
  static const Color onPrimary =
      Color(0xFFFFFFFF); // Văn bản trên nền màu chính
  static const Color onSecondary =
      Color(0xFF072110); // Văn bản trên nền màu phụ
  static const Color onBackground = Color(0xFF072110); // Văn bản trên nền
  static const Color onSurface = Color(0xFF072110); // Văn bản trên bề mặt

  // Error Colors
  static const Color error = Color(0xFFB00020); // Màu lỗi
  static const Color onError = Color(0xFFFFFFFF); // Văn bản trên nền lỗi
}
