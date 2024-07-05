import 'package:flutter/material.dart';

class Preview extends StatelessWidget {
  const Preview({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _Title(),
            _Content(),
            SizedBox(height: 10),
            _Category(),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '제목' * 100,
      maxLines: 1,
      style: Theme.of(context).textTheme.titleLarge,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '내용' * 1000,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '카테고리',
      maxLines: 3,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
