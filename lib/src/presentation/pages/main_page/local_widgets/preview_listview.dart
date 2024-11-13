import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/presentation/riverpods/main_notifier.dart';
import 'package:kkw_blog/src/presentation/widgets/loading_progress.dart';

import 'preview.dart';

class PreviewListview extends ConsumerWidget {
  const PreviewListview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _WidgetState state = ref.watch(
      mainNotifierProvider.select(
        (value) => _WidgetState(posts: value.posts, isLoading: value.isLoading),
      ),
    );

    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: _addDivider(
              state.posts.map((post) => Preview(post: post)).toList()),
        ),
        if (state.isLoading) const LoadingProgress(),
      ],
    );
  }

  List<Widget> _addDivider(List<Preview> previews) {
    int length = previews.length;
    List<Widget> newWidgets = previews.cast<Widget>().toList();

    for (int i = 0; i < length * 2 + 1; i += 2) {
      newWidgets.insert(
        i,
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            thickness: 2,
          ),
        ),
      );
    }

    return newWidgets;
  }
}

class _WidgetState {
  final List<Post> posts;
  final bool isLoading;

  const _WidgetState({
    required this.posts,
    required this.isLoading,
  });
}
