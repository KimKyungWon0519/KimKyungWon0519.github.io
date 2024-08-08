import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  final String content;
  const Body(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      shrinkWrap: true,
      data: content,
      padding: EdgeInsets.zero,
      imageBuilder: (uri, title, alt) {
        Widget widget;

        if (RegExp('.svg').hasMatch(uri.path)) {
          widget = SvgPicture.network(uri.path);
        } else {
          widget = Image.network(uri.path);
        }
        return Center(child: widget);
      },
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
    );
  }
}
