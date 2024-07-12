import 'package:flutter/material.dart';
import 'package:kkw_blog/src/core/utils/models/post.dart';
import 'package:kkw_blog/src/feature/presentation/home_page/local_widgets/side_margin.dart';
import 'package:markdown_widget/markdown_widget.dart';

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
          child: MarkdownBlock(
            data: post.content,
          ),
        ),
      ),
    );
  }
}
