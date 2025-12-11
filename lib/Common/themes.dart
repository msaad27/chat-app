import 'package:chat_app/Common/app_colors.dart';
import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  error: Colors.red,
  onError: Colors.white,
  background: AppColors.background,
  onBackground: AppColors.onSurface,
  surface: AppColors.surface,
  onSurface: AppColors.onSurface,

  // REQUIRED in latest Flutter versions
  surfaceVariant: AppColors.surface,
  onSurfaceVariant: AppColors.onSurface,
);

final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primary.withOpacity(0.9),
  onPrimary: AppColors.onPrimary,
  secondary: AppColors.secondary.withOpacity(0.9),
    onSecondary: AppColors.onSecondaryDark,
  error: Colors.redAccent,
  onError: Colors.black,
  background: Color(0xFF0B1220),
  onBackground: Colors.white,
  surface: Color(0xFF0D1722),
  onSurface: Colors.white,
);

ThemeData lightTheme = ThemeData.from(colorScheme: lightColorScheme).copyWith(
  primaryColor: AppColors.primary,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
  ),
);

ThemeData darkTheme = ThemeData.from(colorScheme: darkColorScheme).copyWith(
  primaryColor: AppColors.primary,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.surface,
    foregroundColor: darkColorScheme.onSurface,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: darkColorScheme.surface,
    filled: true,
  ),
);
