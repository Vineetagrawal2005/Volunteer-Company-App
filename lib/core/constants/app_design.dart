import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0A2540); // Deep Midnight Blue
  static const Color accent = Color.fromARGB(
    255,
    23,
    18,
    126,
  ); // Electric Royal Purple-Blue

  static const Color background = Color(0xFFF8F9FA); // Soft Clean Ice-White
  static const Color cardBackground = Color(0xFFFFFFFF); // Pure White

  static const Color textPrimary = Color(0xFF1C2A38); // Very Dark Navy Text
  static const Color textSecondary = Color(0xFF697A8D); // Cool Slate Grey Text

  static const Color error = Color(0xFFDF1B41); // Vibrant Crimson Red
  static const Color success = Color(0xFF00D4B2); // Bright Mint Teal
}

class AppTextStyles {
  static const TextStyle topHeading = TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );

  static const TextStyle head = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

class AppDimens {
  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;

  static const double radius = 12;

  static const double buttonHeight = 50;
  static const double iconSize = 24;
}
