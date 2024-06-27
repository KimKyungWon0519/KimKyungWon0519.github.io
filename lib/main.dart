import 'package:flutter/material.dart';
import 'package:kkw_blog/src/feature/presentation/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '얼렁뚱땅 개발 블로그',
      theme: ThemeData(
        fontFamily: 'GmarketSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE0F8E8),
        ),
      ),
      home: const HomePage(),
    );
  }
}
