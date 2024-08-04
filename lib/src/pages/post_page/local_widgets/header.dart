import 'package:flutter/material.dart';
import 'package:kkw_blog/src/core/utils/models/post.dart';

import 'catetory.dart';
import 'title.dart' as LocalWidget;
import 'tags.dart';
import 'update_date.dart';

class Header extends StatelessWidget {
  final Post post;

  const Header(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocalWidget.Title(post.title),
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
        const SizedBox(height: 10),
        if (post.thumbnail != null) ...[
          Align(
            alignment: Alignment.center,
            child: Image.network(post.thumbnail!),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
