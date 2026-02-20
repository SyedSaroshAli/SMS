import 'package:flutter/material.dart';
import 'package:school_management_system/theme/app_colors.dart';

class AppTextStyles {
  // Light theme text styles
  static const TextStyle lightHeading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.lightText,
  );

  static const TextStyle lightSubheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.lightText,
  );

  static const TextStyle lightBody = TextStyle(
    fontSize: 16,
    color: AppColors.lightText,
  );

  // Dark theme text styles
  static const TextStyle darkHeading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );

  static const TextStyle darkSubheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
  );

  static const TextStyle darkBody = TextStyle(
    fontSize: 16,
    color: AppColors.darkText,
  );
}