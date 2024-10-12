import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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

MarkdownStyleSheet customMarkdownStyleSheet(BuildContext context) {
  return MarkdownStyleSheet(
    h1: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
    h2: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
    h3: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
    h1Padding: const EdgeInsets.only(top: 32),
    h2Padding: const EdgeInsets.only(top: 16),
    h3Padding: const EdgeInsets.only(top: 8),
  );
}
