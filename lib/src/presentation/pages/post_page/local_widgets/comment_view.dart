import 'package:flutter/material.dart';

class CommentView extends StatelessWidget {
  const CommentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(),
        SizedBox(width: 8),
        Text('유저 이름'),
        Spacer(),
        Text('yyyy/MM/dd'),
      ],
    );
  }
}
