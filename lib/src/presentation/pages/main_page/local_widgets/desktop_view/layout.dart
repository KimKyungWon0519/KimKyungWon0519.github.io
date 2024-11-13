import 'package:flutter/material.dart';

import '../header.dart';
import 'classified_panel.dart';
import '../preview_listview.dart';

class Layout extends StatelessWidget {
  final ScrollController scrollController;

  const Layout({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: const Column(
        children: [
          Header(),
          _Body(),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: ClassifiedPanel(),
        ),
        Expanded(
          flex: 3,
          child: PreviewListview(),
        ),
        Spacer(flex: 1),
      ],
    );
  }
}
