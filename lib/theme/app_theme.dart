import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      surface: AppColors.lightCardBackground,
      error: AppColors.error,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.lightText,
      onError: AppColors.white,
    ),
    
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
    
    iconTheme: IconThemeData(
      color: AppColors.lightText,
    ),
    
    textTheme: TextTheme(
      displayLarge: TextStyle(color: AppColors.lightText),
      displayMedium: TextStyle(color: AppColors.lightText),
      displaySmall: TextStyle(color: AppColors.lightText),
      headlineLarge: TextStyle(color: AppColors.lightText),
      headlineMedium: TextStyle(color: AppColors.lightText),
      headlineSmall: TextStyle(color: AppColors.lightText),
      titleLarge: TextStyle(color: AppColors.lightText),
      titleMedium: TextStyle(color: AppColors.lightText),
      titleSmall: TextStyle(color: AppColors.lightText),
      bodyLarge: TextStyle(color: AppColors.lightText),
      bodyMedium: TextStyle(color: AppColors.lightText),
      bodySmall: TextStyle(color: AppColors.lightText),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      surface: AppColors.darkCardBackground,
      error: AppColors.error,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.darkText,
      onError: AppColors.white,
    ),
    
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
    
    iconTheme: IconThemeData(
      color: AppColors.darkText,
    ),
    
    textTheme: TextTheme(
      displayLarge: TextStyle(color: AppColors.darkText),
      displayMedium: TextStyle(color: AppColors.darkText),
      displaySmall: TextStyle(color: AppColors.darkText),
      headlineLarge: TextStyle(color: AppColors.darkText),
      headlineMedium: TextStyle(color: AppColors.darkText),
      headlineSmall: TextStyle(color: AppColors.darkText),
      titleLarge: TextStyle(color: AppColors.darkText),
      titleMedium: TextStyle(color: AppColors.darkText),
      titleSmall: TextStyle(color: AppColors.darkText),
      bodyLarge: TextStyle(color: AppColors.darkText),
      bodyMedium: TextStyle(color: AppColors.darkText),
      bodySmall: TextStyle(color: AppColors.darkText),
    ),
  );
}