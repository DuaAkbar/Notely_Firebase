import 'package:flutter/material.dart';

final ThemeData mytheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    surface: Color(0xFFF0F4FF),
    onSurface: Color(0xFF1A1F36),
    surfaceTint: Color(0xFFD0DCFF),
    primary: Color(0xFF3D5AFE),
    onPrimary: Colors.white,
    secondary: Color(0xFF8C9EFF),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    surfaceTintColor: Color(0xFF3D5AFE),
  ),

  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    indicatorColor: Color(0xFF8C9EFF),
    iconTheme: WidgetStatePropertyAll(
      IconThemeData(
        color: Color(0xFF3D5AFE),
        size: 30,
      ),
    ),
  ),
);