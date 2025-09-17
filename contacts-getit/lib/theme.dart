import 'package:flutter/material.dart';

// Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Colors.green, // Primary color for light theme
    onPrimary: Colors.white, // Text/icon color on primary
    secondary: Colors.green, // Secondary color
    surface: Colors.white, // Background color for surfaces
    onSurface: Colors.black, // Text/icon color on surfaces
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color.fromARGB(255, 3, 76, 5), // Primary color for dark theme
    onPrimary: Colors.white,
    secondary: Colors.teal,
    surface: Colors.black,
    onSurface: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 3, 76, 5), 
    foregroundColor: Colors.white,
  ),
);