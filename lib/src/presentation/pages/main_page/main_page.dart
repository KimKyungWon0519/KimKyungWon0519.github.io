import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/src/presentation/riverpods/main_notifier.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:kkw_blog/src/presentation/widgets/fab_panel.dart';

import 'local_widgets/desktop_view/layout.dart' as Desktop;
import 'local_widgets/mobile_view/layout.dart' as Mobile;

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = useScrollController();
    final ObjectRef<bool> isUpdate = useRef(false);

    useEffect(() {
      void updateData() {
        if (!isUpdate.value &&
            scrollController.offset >=
                scrollController.position.maxScrollExtent * 0.5) {
          isUpdate.value = true;

          ref
              .read(mainNotifierProvider.notifier)
              .increaseStartOffset()
              .then((value) => isUpdate.value = false);
        }
      }

      scrollController.addListener(updateData);

      return () => scrollController.removeListener(updateData);
    }, [scrollController]);

    return Title(
      color: Colors.white,
      title: Messages.of(context).blogTitle,
      child: Scaffold(
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
            child: ScreenTypeLayout.builder(
              desktop: (_) =>
                  Desktop.Layout(scrollController: scrollController),
              mobile: (_) => Mobile.Lyaout(scrollController: scrollController),
            ),
          ),
        ),
        floatingActionButton: FabPanel(scrollController: scrollController),
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
