import 'package:flutter/material.dart';

import 'blog_title.dart';
import 'introduction.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BlogTitle(),
        SizedBox(height: 10),
        Introduction(),
      ],
    );
  }
}
