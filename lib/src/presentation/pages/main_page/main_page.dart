import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';

import 'local_widgets/introduction.dart';
import 'local_widgets/theme_mode_fab.dart';
import 'local_widgets/blog_title.dart';
import 'local_widgets/classified_panel.dart';
import 'local_widgets/preview_listview.dart';

class MainPage extends HookWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = useScrollController();

    return Title(
      color: Colors.white,
      title: Messages.of(context).blogTitle,
      child: Scaffold(
        body: Listener(
          onPointerSignal: (event) => _scrollingOutside(
            event,
            scrollController,
          ),
          child: Scrollbar(
            thumbVisibility: true,
            controller: scrollController,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: CustomScrollView(
                  controller: scrollController,
                  scrollBehavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  slivers: const [
                    _HorizontalPaddingSliver(),
                    SliverToBoxAdapter(child: _Header()),
                    _BodyAreaSliver(),
                    _HorizontalPaddingSliver(),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: const ThemeModeFab(),
      ),
    );
  }

  void _scrollingOutside(
    PointerSignalEvent event,
    ScrollController controller,
  ) {
    if (event is! PointerScrollEvent) {
      return;
    }

    double newPose = controller.offset + event.scrollDelta.dy;

    if (0 < newPose && newPose < controller.position.maxScrollExtent) {
      controller.jumpTo(controller.offset + event.scrollDelta.dy);
    }
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
