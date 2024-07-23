import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:kkw_blog/src/core/utils/models/post.dart';
import 'package:web/web.dart';

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
    platformViewRegistry.registerViewFactory(
      'comment',
      (int viewId, {Object? params}) {
        return HTMLScriptElement()
          ..src = 'https://utteranc.es/client.js'
          ..async = true
          ..style.width = '100%'
          ..style.height = '100%';
      },
    );

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
                  const SizedBox(
                    height: 400,
                    child: HtmlElementView(
                      viewType: 'comment',
                      creationParams: {
                        'repo': "KimKyungWon0519/KimKyungWon0519.github.io",
                        'issue-term': "pathname",
                        'theme': "github-light",
                        'crossorigin': "anonymous",
                      },
                    ),
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
