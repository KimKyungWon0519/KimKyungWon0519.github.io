import 'package:flutter/material.dart';
import 'package:kkw_blog/src/feature/presentation/home_page/local_widgets/preview.dart';
import 'package:kkw_blog/src/feature/presentation/home_page/local_widgets/scroll_to_top_fab.dart';

import '../header.dart';
import 'atrribute.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({super.key});

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  late final ScrollController _controller;
  List<Preview> _previews = List.generate(
    10,
    (index) => const Preview(),
  );
  bool _isShowToTopFAB = false;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()
      ..addListener(
        () {
          if (_controller.offset >= _controller.position.maxScrollExtent) {
            setState(() {
              _previews.addAll(List.generate(
                10,
                (index) => const Preview(),
              ));
            });
          }

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            double padding = (constraints.maxWidth - 1200) / 2;

            if (padding < 0) padding = 0;

            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: padding,
              ),
              child: Column(
                children: [
                  const Header(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Atrribute(),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(children: _previews),
                      ),
                      const Spacer()
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton:
          _isShowToTopFAB ? ScrollToTopFAB(onPressed: _scrollToTop) : null,
    );
  }

  void _scrollToTop() {
    _controller.jumpTo(0);

    setState(() {
      _previews = List.generate(
        10,
        (index) => const Preview(),
      );
    });
  }
}
