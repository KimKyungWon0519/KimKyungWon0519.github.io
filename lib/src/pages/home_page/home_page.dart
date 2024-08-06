import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kkw_blog/src/constants/app_constant.dart';
import 'package:kkw_blog/src/riverpods/post_notifier.dart';
import 'package:kkw_blog/src/utils/models/posts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'local_widgets/desktop/desktop_view.dart';
import 'local_widgets/mobile/mobile_view.dart';
import 'local_widgets/scroll_to_top_fab.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final ScrollController _controller;
  bool _isShowToTopFAB = false;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()
      ..addListener(
        () {
          if (!_isShowToTopFAB && _controller.offset > 50) {
            setState(() {
              _isShowToTopFAB = true;
            });
          } else if (_isShowToTopFAB && _controller.offset == 0) {
            setState(() {
              _isShowToTopFAB = false;
            });
          }
        },
      );

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(postNotifierProvider.notifier).state = posts;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Posts posts = ref.watch(postNotifierProvider);

    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: ScreenTypeLayout.builder(
          desktop: (context) => DesktopView(posts: posts),
          mobile: (context) => MobileView(posts: posts),
        ),
      ),
      floatingActionButton: _isShowToTopFAB
          ? ScrollToTopFAB(
              onPressed: () => _controller.jumpTo(0),
            )
          : null,
    );
  }
}
