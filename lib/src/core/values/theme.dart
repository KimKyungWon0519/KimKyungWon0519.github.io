import 'package:flutter/material.dart';
import 'package:kkw_blog/src/core/values/color_sheme.dart';

final ThemeData lightThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: lightScheme(),
  brightness: Brightness.light,
);

final ThemeData darkThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  colorScheme: darkScheme(),
  brightness: Brightness.dark,
);
