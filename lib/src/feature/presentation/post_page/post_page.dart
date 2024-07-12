import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kkw_blog/src/core/utils/models/post.dart';
import 'package:kkw_blog/src/feature/presentation/wigets/side_margin.dart';

import 'local_widgets/header.dart';
import 'local_widgets/catetory.dart';
import 'local_widgets/update_date.dart';
import 'local_widgets/tags.dart';

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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(post.title),
                  const SizedBox(height: 10),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Category(post.catetory),
                        const VerticalDivider(),
                        UploadDate(post.createdAt),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Tags(post.tags),
                  const SizedBox(height: 20),
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
      ),
    );
  }
}
