import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {

  // Observable theme mode
  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  // Toggle between light and dark theme
  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.light;
    }

    // Notify GetX to change theme globally
    Get.changeThemeMode(themeMode.value);
  }

  // Set a specific theme
  void setTheme(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
  }

  // Check if dark mode is active
  bool get isDarkMode => themeMode.value == ThemeMode.dark;
}
