import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/core/riverpods/theme_mode_notifier.dart';

class ThemeModeFab extends ConsumerWidget {
  const ThemeModeFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeMode themeMode = ref.watch(themeModeNotifierProvider);

    return FloatingActionButton(
      onPressed: () => ref.read(themeModeNotifierProvider.notifier).update(),
      child: Icon(
        themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
      ),
    );
  }
}
