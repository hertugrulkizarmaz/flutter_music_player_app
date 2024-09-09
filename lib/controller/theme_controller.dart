import 'package:flutter/material.dart';
import 'package:flutter_music_player/themes/dark_mode.dart';
import 'package:flutter_music_player/themes/light_mode.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  // initially, lightmode
  final _themeData= lightMode.obs;

  // save theme mode to phone 
  SharedPreferences? _prefs;

  ThemeController() {
    _loadThemeFromPrefs();
  }

  // get theme
  ThemeData get themeData => _themeData.value;

  // is dark mode
  bool get isDarkMode => _themeData.value == darkMode;

  // set theme
  set themeData(ThemeData themeData) {
    _themeData.value = themeData;
    _saveThemeToPrefs(); // save to theme data
    //update UI
    update();
  }

  // toggle theme
  void toggleTheme() {
    if (_themeData.value == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  // load theme data with sharedpreferences
  void _loadThemeFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final isDarkMode = _prefs?.getBool('isDarkMode') ?? false;
    _themeData.value = isDarkMode ? darkMode : lightMode;
    update();
  }

  // save theme data with sharedpreferences
  void _saveThemeToPrefs() async {
    await _prefs?.setBool('isDarkMode', _themeData.value == darkMode);
  }
}
