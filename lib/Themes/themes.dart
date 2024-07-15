import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF075E54),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Color(0xFF075E54),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black54,
        fontSize: 24.0,
      ),
      bodyMedium: TextStyle(
        color: Colors.black54,
        fontSize: 20.0,
      ),
      bodySmall: TextStyle(
        color: Colors.black54,
        fontSize: 16.0,
      ),
    ),
    colorScheme: ColorScheme(
      primary: Color(0xFF075E54),
      onPrimary: Colors.white,
      secondary: Color(0xFF128C7E),
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      background: Colors.white,
      onBackground: Colors.black,
      error: Colors.red.shade600,
      onError: Colors.white,
      brightness: Brightness.light,
    ).copyWith(background: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey.shade300;
            }
            return Color(0xFF075E54);
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF128C7E),
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF121212),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    ),
    colorScheme: ColorScheme(
      primary: Color(0xFF128C7E),
      onPrimary: Colors.white,
      secondary: Color(0xFF25D366),
      onSecondary: Colors.white,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
      background: Color(0xFF121212),
      onBackground: Colors.white,
      error: Colors.red.shade400,
      onError: Colors.white,
      brightness: Brightness.dark,
    ).copyWith(background: Color(0xFF121212)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey.shade800;
            }
            return Color(0xFF128C7E);
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
    ),
  );
}
