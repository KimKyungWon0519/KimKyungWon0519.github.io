import 'package:flutter/material.dart';
import 'package:kkw_blog/src/core/utils/models/post.dart';
import 'package:kkw_blog/src/feature/presentation/wigets/side_margin.dart';
import 'package:markdown_widget/markdown_widget.dart';

import 'local_widgets/title.dart';

class PostPage extends StatelessWidget {
  final Post post;

  const PostPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SideMargin(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(post.title),
              MarkdownBlock(
                data: post.content,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
