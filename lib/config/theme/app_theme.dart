

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const seedColor = Color(0xFF1E1C36);

class AppTheme {

  final bool isDarkMode;

  AppTheme({required this.isDarkMode});


  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seedColor,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,

    listTileTheme: ListTileThemeData(
      iconColor: seedColor

    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1E1C36),
      surfaceTintColor: Colors.transparent,
    ),
  );

  static setSystemUIOverlayStyle({required bool isDarkMode}) {

    final themeBrightness = isDarkMode ? Brightness.dark : Brightness.light;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: themeBrightness,
        statusBarIconBrightness: themeBrightness,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: themeBrightness,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }
}