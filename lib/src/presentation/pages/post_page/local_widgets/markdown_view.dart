import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kkw_blog/resource/values/theme.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';
import 'package:markdown/markdown.dart' as md;

class MarkdownView extends StatelessWidget {
  final String routeID;
  final String content;

  const MarkdownView({
    super.key,
    required this.content,
    required this.routeID,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      shrinkWrap: true,
      softLineBreak: true,
      styleSheet: customMarkdownStyleSheet(context),
      data: content,
      inlineSyntaxes: [
        InlineCodeSyntax(),
      ],
      builders: {
        'inline code': InlineCodeBuilder(),
        'code': CodeBlockBuilder(),
      },
      imageBuilder: (uri, title, alt) {
        String originUri = uri.path;
        Widget child;

        if (RegExp(r'.svg').hasMatch(originUri)) {
          child = SvgPicture.network('$postBucketURL$routeID/$originUri');
        } else {
          child = Image.network('$postBucketURL$routeID/$originUri');
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

class InlineCodeSyntax extends md.InlineSyntax {
  InlineCodeSyntax() : super(r'`(.*?)`');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final element = md.Element.text("inline code", match[1]!);
    parser.addNode(element);

    return true;
  }
}

class InlineCodeBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        element.textContent,
        style: GoogleFonts.robotoMono(color: Colors.white),
      ),
    );
  }
}

class CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: HighlightView(
        element.textContent.substring(0, element.textContent.length - 1),
        theme: atomOneDarkTheme,
        language: 'kotlin',
        padding: const EdgeInsets.all(16),
        textStyle: GoogleFonts.robotoMono(),
      ),
    );
  }
}
