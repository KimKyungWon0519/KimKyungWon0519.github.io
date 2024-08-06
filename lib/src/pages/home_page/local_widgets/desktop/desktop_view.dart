import 'package:flutter/material.dart';
import 'package:kkw_blog/src/utils/models/posts.dart';

import '../header.dart';
import '../preview.dart';
import 'attribute.dart';

class DesktopView extends StatelessWidget {
  final Posts posts;

  const DesktopView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        margin: const EdgeInsets.symmetric(vertical: kToolbarHeight),
        child: Column(
          children: [
            const Header(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Attribute(),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: posts
                          .map(
                            (post) => Preview(
                              post: post,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const Spacer()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
