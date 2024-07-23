import 'package:flutter/material.dart';
import 'package:kkw_blog/src/core/utils/models/post.dart';

import 'local_widgets/body.dart';
import 'local_widgets/header.dart';

class PostPage extends StatelessWidget {
  final Post post;

  const PostPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(16),
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(post),
                  Body(post.content),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
