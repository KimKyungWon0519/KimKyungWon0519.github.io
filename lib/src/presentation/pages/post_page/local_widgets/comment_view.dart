import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/src/core/utils/response_result.dart';
import 'package:kkw_blog/src/domain/models/comment.dart';
import 'package:kkw_blog/src/presentation/riverpods/post_notifier.dart';
import 'package:kkw_blog/src/presentation/widgets/error_dialog.dart';
import 'package:kkw_blog/src/presentation/widgets/loading_dialog.dart';

class CommentView extends StatelessWidget {
  final Comment comment;
  final String authUUID;

  const CommentView({
    super.key,
    required this.comment,
    required this.authUUID,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(comment.user.avatar ?? ''),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                comment.user.userName,
                maxLines: 1,
              ),
            ),
            Text(DateFormat('yyyy/MM/dd hh:mm a').format(comment.createAt!)),
          ],
        ),
        const SizedBox(height: 8),
        Text(comment.content),
        if (authUUID == comment.user.uuid) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: _DeleteButton(
              commentID: comment.id ?? -1,
            ),
          ),
        ]
      ],
    );
  }
}

class _DeleteButton extends ConsumerWidget {
  final int commentID;

  const _DeleteButton({
    super.key,
    required this.commentID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _deleteEvent(context, ref),
      child: Text(
        '삭제',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  void _deleteEvent(BuildContext context, WidgetRef ref) async {
    showLoadingDialog(context);

    PostNotifier postNotifier = ref.read(postNotifierProvider.notifier);

    ResponseResult? responseResult =
        await postNotifier.deleteComment(commentID);

    context.pop();

    if (responseResult != null && responseResult.isSuccess) {
      postNotifier.updateComment();
    } else {
      String errorMsg = '';

      errorMsg = Messages.of(context).failureDeleteComment;

      showErrorDialog(
        context: context,
        errorMsg: errorMsg,
      );
    }
  }
}
