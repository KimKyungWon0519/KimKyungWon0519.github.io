import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkw_blog/src/domain/models/comment.dart';

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
          const Align(
            alignment: Alignment.bottomRight,
            child: _DeleteButton(),
          ),
        ]
      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        '삭제',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
