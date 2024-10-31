import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/domain/models/comment.dart';
import 'package:kkw_blog/src/presentation/pages/post_page/local_widgets/comment_view.dart';
import 'package:kkw_blog/src/presentation/riverpods/post_notifier.dart';

class CommentListview extends ConsumerWidget {
  const CommentListview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Comment> comments =
        ref.watch(postNotifierProvider.select((value) => value.comments));

    return SliverList.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: CommentView(
          comment: comments[index],
        ),
      ),
      itemCount: comments.length,
    );
  }
}