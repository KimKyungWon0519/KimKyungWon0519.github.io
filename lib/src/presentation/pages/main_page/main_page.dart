import 'package:flutter/material.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';

import 'local_widgets/blog_title.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      color: Colors.white,
      title: Messages.of(context).blogTitle,
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: kToolbarHeight),
            constraints: const BoxConstraints(maxWidth: 1200),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlogTitle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
