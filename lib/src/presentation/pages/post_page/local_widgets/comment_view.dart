import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkw_blog/src/domain/models/comment.dart';

class CommentView extends StatelessWidget {
  final Comment comment;

  const CommentView({
    super.key,
    required this.comment,
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
      ],
    );
  }
}
