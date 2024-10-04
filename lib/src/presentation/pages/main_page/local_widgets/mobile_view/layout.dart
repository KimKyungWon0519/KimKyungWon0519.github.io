import 'package:flutter/material.dart';

import '../../sliver_widgets/header.dart';
import '../../sliver_widgets/preview_listview.dart';

class Lyaout extends StatelessWidget {
  final ScrollController scrollController;

  const Lyaout({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        controller: scrollController,
        scrollBehavior:
            ScrollConfiguration.of(context).copyWith(scrollbars: false),
        slivers: [
          _HorizontalPaddingSliver(),
          SliverToBoxAdapter(child: Header()),
          PreviewListview(),
        ],
      ),
    );
  }
}

class _HorizontalPaddingSliver extends StatelessWidget {
  const _HorizontalPaddingSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(height: 16));
  }
}
