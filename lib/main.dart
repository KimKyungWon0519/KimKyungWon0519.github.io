import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kkw_blog/src/constants/app_constant.dart';
import 'package:kkw_blog/src/utils/data_sources/post_helper.dart';
import 'package:kkw_blog/src/pages/home_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const PostHelper postHelper = PostHelper();

  posts = await postHelper.createPosts();
  categories = postHelper.getCategories();
  tags = postHelper.getTags();

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
