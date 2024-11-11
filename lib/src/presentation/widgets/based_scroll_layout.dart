import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/presentation/widgets/custom_header.dart';
import 'package:kkw_blog/src/presentation/widgets/fab_panel.dart';

abstract class BasedScrollLayout extends HookConsumerWidget {
  const BasedScrollLayout({
    super.key,
  });

  Widget childBuild(
    BuildContext context,
    WidgetRef ref,
    ScrollController scrollController,
    ObjectRef<bool> canScrolling,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> canScrolling = useRef(true);

    return Scaffold(
      body: Listener(
        onPointerSignal: (event) {
          if (canScrolling.value) {
            _scrollingOutside(
              event,
              scrollController,
            );
          }
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: CustomHeader(),
                ),
                childBuild(context, ref, scrollController, canScrolling),
                const SizedBox(height: kToolbarHeight),
              ],
            ),
          ),
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

    if (0 > newPose) {
      newPose = 0;
    } else if (controller.position.maxScrollExtent < newPose) {
      newPose = controller.position.maxScrollExtent;
    }

    controller.jumpTo(newPose);
  }
}
