import 'package:flutter/material.dart';
import 'package:chat_app/Common/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final bool obscureText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.obscureText = false,
    this.prefixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark
        ? theme.cardColor.withOpacity(0.12)
        : theme.cardColor;
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon == null
            ? null
            : Icon(prefixIcon, size: 20, color: theme.iconTheme.color),
        filled: true,
        fillColor: bgColor,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}
