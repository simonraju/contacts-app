import 'package:flutter/material.dart';

// Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Colors.purpleAccent, // Primary color for light theme
    onPrimary: Colors.white, // Text/icon color on primary
    secondary: Colors.purpleAccent, // Secondary color
    surface: Colors.white, // Background color for surfaces
    onSurface: Colors.black, // Text/icon color on surfaces
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.purpleAccent,
    foregroundColor: Colors.white,
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color.fromARGB(255, 110, 0, 130), // Primary color for dark theme
    onPrimary: Colors.white,
    secondary: Colors.purple,
    surface: Color.fromARGB(255, 19, 19, 19),
    onSurface: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 74, 24, 83), 
    foregroundColor: Colors.white,
  ),
);