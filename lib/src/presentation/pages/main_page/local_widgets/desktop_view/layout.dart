import 'package:flutter/material.dart';

import '../blog_title.dart';
import '../introduction.dart';
import 'classified_panel.dart';
import 'preview_listview.dart';

class Layout extends StatelessWidget {
  final ScrollController scrollController;

  const Layout({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: CustomScrollView(
          controller: scrollController,
          scrollBehavior:
              ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers: const [
            _HorizontalPaddingSliver(),
            SliverToBoxAdapter(child: _Header()),
            _BodyAreaSliver(),
            _HorizontalPaddingSliver(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BlogTitle(),
        SizedBox(height: 10),
        Introduction(),
      ],
    );
  }
}

class _BodyAreaSliver extends StatelessWidget {
  const _BodyAreaSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverCrossAxisGroup(
      slivers: [
        SliverCrossAxisExpanded(
          flex: 1,
          sliver: SliverToBoxAdapter(
            child: ClassifiedPanel(),
          ),
        ),
        SliverCrossAxisExpanded(
          flex: 3,
          sliver: PreviewListview(),
        ),
        SliverCrossAxisExpanded(
          flex: 1,
          sliver: SliverToBoxAdapter(),
        ),
      ],
    );
  }
}

class _HorizontalPaddingSliver extends StatelessWidget {
  const _HorizontalPaddingSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SizedBox(height: kToolbarHeight),
    );
  }
}
