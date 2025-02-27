import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';

class AppTheme {
  static OutlineInputBorder border([Color color = AppPallete.borderColor]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 3),
      borderRadius: BorderRadius.circular(16),
    );
  }

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(24),
        enabledBorder: border(),
        focusedBorder: border(AppPallete.gradient2),
        errorBorder: border(Colors.red)),
  );
  static final lightThemeMode = ThemeData.light().copyWith();
}
