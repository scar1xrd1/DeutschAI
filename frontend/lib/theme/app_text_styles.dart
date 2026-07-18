import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const title = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const subtitle = TextStyle(
    fontSize: 18,
    color: AppColors.textSecondary,
  );

  static const body = TextStyle(fontSize: 16, color: AppColors.textPrimary);

  static const hint = TextStyle(fontSize: 16, color: AppColors.hint);
}
