import 'package:flutter/material.dart';

import '../scroll_to_top_fab.dart';
import '../preview.dart';
import '../header.dart';
import 'atrribute.dart';

class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Header(),
              const Align(
                alignment: Alignment.topLeft,
                child: Menu(),
              ),
              ..._previews,
            ],
          ),
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
