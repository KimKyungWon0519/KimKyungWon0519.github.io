import 'package:flutter/material.dart';

class UploadDate extends StatelessWidget {
  final String createAt;

  const UploadDate(this.createAt, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      createAt,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[700],
          ),
    );
  }
}
