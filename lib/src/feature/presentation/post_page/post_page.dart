import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kkw_blog/src/core/utils/models/post.dart';
import 'package:kkw_blog/src/feature/presentation/wigets/side_margin.dart';
import 'package:markdown_widget/markdown_widget.dart';

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
          child: SideMargin(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(post.title),
                Row(
                  children: [],
                ),
                Markdown(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  data: post.content,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
