import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'local_widgets/desktop/desktop_view.dart';
import 'local_widgets/mobile/mobile_view.dart';
import 'local_widgets/scroll_to_top_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: ScreenTypeLayout.builder(
          desktop: (context) => const DesktopView(),
          mobile: (context) => const MobileView(),
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
