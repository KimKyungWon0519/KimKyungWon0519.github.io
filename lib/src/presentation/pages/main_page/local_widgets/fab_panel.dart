import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'scroll_up_fab.dart';
import 'theme_mode_fab.dart';

class FabPanel extends HookWidget {
  final ScrollController? scrollController;

  const FabPanel({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isShowScrollUpFab = useState(false);
    final AnimationController animationController =
        useAnimationController(duration: Durations.short4);
    final Animation<Offset> slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -(1 + (16 / 56))),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ));
    final Animation<double> fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ));

    useEffect(() {
      void updateScrollUpFab() {
        if (!isShowScrollUpFab.value && (scrollController?.offset ?? 0) > 100) {
          isShowScrollUpFab.value = true;
          animationController.forward();
        } else if (isShowScrollUpFab.value &&
            (scrollController?.offset ?? 0) == 0) {
          isShowScrollUpFab.value = false;
          animationController.reverse();
        }
      }

      scrollController?.addListener(updateScrollUpFab);

      return () => scrollController?.removeListener(updateScrollUpFab);
    }, [scrollController]);

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SlideTransition(
          position: slideAnimation,
          child: const ThemeModeFab(),
        ),
        FadeTransition(
          opacity: fadeAnimation,
          child: ScrollUpFab(
            onPressed: () {
              scrollController?.animateTo(
                0,
                duration: Durations.short4,
                curve: Curves.ease,
              );
            },
          ),
        ),
      ],
    );
  }
}
