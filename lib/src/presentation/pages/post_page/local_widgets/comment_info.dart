import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/src/presentation/riverpods/post_notifier.dart';

class CommentInfo extends StatelessWidget {
  const CommentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(width: 8),
        _CommentCount(),
        Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}

class _CommentCount extends ConsumerWidget {
  const _CommentCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int count = ref
        .watch(postNotifierProvider.select((value) => value.comments.length));

    return Text(Messages.of(context).commentCount(count));
  }
}
