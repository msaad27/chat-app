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
  surface: AppColors.surface,
  onSurface: AppColors.onSurface,

  // REQUIRED in latest Flutter versions
  surfaceContainerHighest: AppColors.surface,
  onSurfaceVariant: AppColors.onSurface,
);

final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primary.withOpacity(0.9),
  onPrimary: AppColors.onPrimary,
  secondary: AppColors.secondary.withOpacity(0.9),
    onSecondary: AppColors.onSecondaryDark,
  error: AppColors.red,
  onError: Colors.black,
  background: Color(0xFF0B1220),
  onBackground: AppColors.surface,
  surface: AppColors.black,
  onSurface: AppColors.surface,
);

ThemeData lightTheme = ThemeData.from(colorScheme: lightColorScheme).copyWith(
  primaryColor: AppColors.primary,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.surface,
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
