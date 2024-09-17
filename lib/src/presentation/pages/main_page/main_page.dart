import 'package:flutter/material.dart';

import 'local_widgets/blog_title.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BlogTitle(),
    );
  }
}
