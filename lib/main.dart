import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/core/routes/app_pages.dart';
import 'package:kkw_blog/src/core/values/theme.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightThemeData,
      darkTheme: darkThemeData,
      routerConfig: AppPages.routeConfigs,
    );
  }
}
