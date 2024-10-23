import 'package:flutter/material.dart';

class CommentView extends StatelessWidget {
  const CommentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(),
            SizedBox(width: 8),
            Text('유저 이름'),
            Spacer(),
            Text('yyyy/MM/dd'),
          ],
        ),
        SizedBox(height: 8),
        Text('쀏' * 500),
      ],
    );
  }
}
