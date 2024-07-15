// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkzapp/Themes/themes.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _currentTheme;
  bool _isDarkMode;

  ThemeNotifier(this._isDarkMode)
      : _currentTheme =
            _isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme;

  ThemeData get currentTheme => _currentTheme;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    _currentTheme = _isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme;
    notifyListeners();

    // Save theme preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  static Future<ThemeNotifier> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    return ThemeNotifier(isDarkMode);
  }
}
