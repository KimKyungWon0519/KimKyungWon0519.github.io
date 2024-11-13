import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/src/core/utils/seo.dart';
import 'package:kkw_blog/src/presentation/riverpods/main_notifier.dart';
import 'package:kkw_blog/src/presentation/widgets/based_scroll_layout.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:html';

import 'local_widgets/desktop_view/layout.dart' as Desktop;
import 'local_widgets/mobile_view/layout.dart' as Mobile;

class MainPage extends BasedScrollLayout {
  const MainPage({super.key});

  @override
  Widget childBuild(
    BuildContext context,
    WidgetRef ref,
    ScrollController scrollController,
    ObjectRef<bool> canScrolling,
  ) {
    final ObjectRef<bool> isUpdate = useRef(false);

    useEffect(() {
      Future.delayed(Duration.zero).then(
        (value) {
          String title = Messages.of(context).blogTitle;
          String description = Messages.of(context).introduction;
          String href = window.location.href;

          createMetaTag(title, description);
          createLinkTag(href);
          createOpenGraph(title, description, href);
        },
      );
      return null;
    }, []);

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

    return ScreenTypeLayout.builder(
      desktop: (_) => Desktop.Layout(scrollController: scrollController),
      mobile: (_) => Mobile.Lyaout(scrollController: scrollController),
    );
  }
}
