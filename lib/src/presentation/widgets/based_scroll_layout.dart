import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/presentation/widgets/fab_panel.dart';

abstract class BasedScrollLayout extends HookConsumerWidget {
  const BasedScrollLayout({super.key});

  Widget childBuild(
    BuildContext context,
    WidgetRef ref,
    ScrollController scrollController,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = useScrollController();

    return Scaffold(
      body: Listener(
        onPointerSignal: (event) => _scrollingOutside(
          event,
          scrollController,
        ),
        child: RawScrollbar(
          trackColor: Colors.grey.withOpacity(.3),
          thumbVisibility: true,
          radius: const Radius.circular(30),
          controller: scrollController,
          thickness: 5,
          child: childBuild(context, ref, scrollController),
        ),
      ),
      floatingActionButton: FabPanel(scrollController: scrollController),
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
