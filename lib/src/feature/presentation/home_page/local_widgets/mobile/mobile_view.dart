import 'package:flutter/material.dart';
import 'package:kkw_blog/src/core/constants/app_constant.dart';

import '../preview.dart';
import '../header.dart';
import 'atrribute.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Header(),
          const Align(
            alignment: Alignment.topLeft,
            child: Menu(),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: posts
                  .map(
                    (post) => Preview(post: post),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
