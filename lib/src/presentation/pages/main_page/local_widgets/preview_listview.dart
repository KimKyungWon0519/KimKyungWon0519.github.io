import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/presentation/pages/main_page/local_widgets/preview.dart';
import 'package:kkw_blog/src/presentation/riverpods/main_notifier.dart';

class PreviewListview extends ConsumerWidget {
  const PreviewListview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Post> posts =
        ref.watch(mainNotifierProvider.select((value) => value.posts));

    return SliverList.list(
      children: _addDivider(posts.map((post) => Preview(post: post)).toList()),
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
