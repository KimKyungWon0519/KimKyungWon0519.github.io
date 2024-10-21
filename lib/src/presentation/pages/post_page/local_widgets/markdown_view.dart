import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kkw_blog/resource/values/theme.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';

class MarkdownView extends StatelessWidget {
  final String id;
  final String content;

  const MarkdownView({
    super.key,
    required this.content,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      styleSheet: customMarkdownStyleSheet(context),
      data: content,
      imageBuilder: (uri, title, alt) {
        String originUri = uri.path;
        Widget child;

        if (RegExp(r'.svg').hasMatch(originUri)) {
          child = SvgPicture.network('$postBucketURL$id/$originUri');
        } else {
          child = Image.network('$postBucketURL$id/$originUri');
        }

        return Container(
          margin: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
