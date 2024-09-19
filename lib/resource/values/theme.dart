import 'package:flutter/material.dart';
import 'package:kkw_blog/resource/values/color_sheme.dart';

final class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme => defaultTheme(lightScheme());
  static ThemeData get lightMediumContrastTheme =>
      defaultTheme(lightMediumContrastScheme());
  static ThemeData get lightHighContrastThemeData =>
      defaultTheme(lightHighContrastScheme());

  static ThemeData get darkTheme => defaultTheme(darkScheme());
  static ThemeData get darkMediumContrastTheme =>
      defaultTheme(darkMediumContrastScheme());
  static ThemeData get darkHighContrastThemeData =>
      defaultTheme(darkHighContrastScheme());

  static ThemeData defaultTheme(ColorScheme colorScheme) => ThemeData(
        fontFamily: 'GmarketSans',
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        canvasColor: colorScheme.surface,
      );
}
