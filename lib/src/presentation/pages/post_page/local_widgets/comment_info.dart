import 'package:flutter/material.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';

class CommentInfo extends StatelessWidget {
  const CommentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(Messages.of(context).commentCount(0)),
        SizedBox(width: 8),
        Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}
