import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1565C0); // Deep Blue
  static const Color primaryLight = Color(0xFF42A5F5); // Light Blue
  static const Color primaryDark = Color(0xFF0D47A1); // Dark Blue
  
  // Secondary Colors
  static const Color secondary = Color(0xFF2E7D32); // Deep Green
  static const Color secondaryLight = Color(0xFF66BB6A); // Light Green
  static const Color secondaryDark = Color(0xFF1B5E20); // Dark Green
  
  // Accent Colors
  static const Color accent = Color(0xFFFF6F00); // Orange
  static const Color accentLight = Color(0xFFFFB74D); // Light Orange
  
  // Background Colors
  static const Color background = Color(0xFFF5F5F5); // Light Gray
  static const Color surface = Colors.white;
  static const Color cardBackground = Colors.white;
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121); // Dark Gray
  static const Color textSecondary = Color(0xFF757575); // Medium Gray
  static const Color textLight = Colors.white;
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color error = Color(0xFFE53935); // Red
  static const Color warning = Color(0xFFFF9800); // Orange
  static const Color info = Color(0xFF2196F3); // Blue
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFE3F2FD), // Light Blue
      Colors.white,
      Color(0xFFE8F5E8), // Light Green
    ],
  );
}