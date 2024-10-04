import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';

import 'local_widgets/desktop_view/layout.dart' as Desktop;
import 'local_widgets/theme_mode_fab.dart';

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
            child: Desktop.Layout(scrollController: scrollController),
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
