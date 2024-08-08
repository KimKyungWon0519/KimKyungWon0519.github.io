import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kkw_blog/src/constants/supabase.dart';
import 'package:kkw_blog/src/utils/data_sources/post_helper.dart';
import 'package:kkw_blog/src/pages/home_page/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  await PostHelper().initializeValues();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '얼렁뚱땅 개발 블로그',
      theme: ThemeData(
        fontFamily: 'GmarketSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          dynamicSchemeVariant: DynamicSchemeVariant.content,
        ),
      ),
      home: const HomePage(),
    );
  }
}
