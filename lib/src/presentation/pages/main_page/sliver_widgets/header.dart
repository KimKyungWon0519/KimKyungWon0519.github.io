import 'package:flutter/material.dart';

import '../local_widgets/blog_title.dart';
import '../local_widgets/introduction.dart';

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
