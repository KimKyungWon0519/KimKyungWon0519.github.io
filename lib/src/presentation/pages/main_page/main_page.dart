import 'package:flutter/material.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/src/presentation/pages/main_page/local_widgets/introduction.dart';
import 'package:kkw_blog/src/presentation/pages/main_page/local_widgets/theme_mode_fab.dart';

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
            padding: const EdgeInsets.symmetric(
              vertical: kToolbarHeight,
              horizontal: 16,
            ),
            constraints: const BoxConstraints(maxWidth: 1200),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlogTitle(),
                SizedBox(height: 10),
                Introduction(),
              ],
            ),
          ),
        ),
        floatingActionButton: const ThemeModeFab(),
      ),
    );
  }
}
