import 'package:flutter/material.dart';

import 'classified_menu_button.dart';
import '../header.dart';
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
        slivers: const [
          _HorizontalPaddingSliver(),
          SliverToBoxAdapter(child: Header()),
          SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: UnconstrainedBox(
              alignment: Alignment.centerLeft,
              child: ClassifiedMenuButton(),
            ),
          ),
          PreviewListview(),
          _HorizontalPaddingSliver(),
        ],
      ),
    );
  }
}

class _HorizontalPaddingSliver extends StatelessWidget {
  const _HorizontalPaddingSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: SizedBox(height: 16));
  }
}
