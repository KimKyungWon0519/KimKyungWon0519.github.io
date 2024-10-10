import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_notifier.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  void initialize(Brightness brightness) {
    state = brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
  }

  void update() {
    print('update state');
    state = ThemeMode.light == state ? ThemeMode.dark : ThemeMode.light;
  }
}
