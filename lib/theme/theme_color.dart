import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  // Colores principales
  static const Color primary = CupertinoColors.activeBlue;
  static const Color secondary = Color(0xFF3B82F6);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color cardBackground = Color(0xFF1E293B);

  // Degradados
  static const List<Color> backgroundGradient = [
    Color(0xFFE0F2FE),
    Color(0xFF3B82F6),
    Color(0xFF1D4ED8),
  ];

  // Texto
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
}

class MyAppTheme {
  // 🟢 CupertinoThemeData puro para CupertinoApp
  static CupertinoThemeData get cupertinoLightTheme {
    return const CupertinoThemeData(
      brightness: Brightness.dark, // O Brightness.light según el tono de tu app
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      barBackgroundColor: CupertinoColors.secondarySystemFill,
      
      // Configuración global de tipografía en Cupertino
      textTheme: CupertinoTextThemeData(
        primaryColor: Colors.white,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        navTitleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        navLargeTitleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        actionTextStyle: TextStyle(
          color: AppColors.secondary,
          fontSize: 17,
        ),
      ),
    );
  }
}