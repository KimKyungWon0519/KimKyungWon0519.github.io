import 'package:flutter/material.dart';

class Preview extends StatelessWidget {
  const Preview({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _Image(
                  height: constraints.maxWidth * 0.5,
                ),
                const SizedBox(height: 10),
                const _Title(),
                const _Content(),
                const SizedBox(height: 10),
                const IntrinsicHeight(
                  child: Row(
                    children: [
                      _Category(),
                      VerticalDivider(),
                      _UploadDate(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Image extends StatelessWidget {
  final double? height;

  const _Image({
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        'https://cdn.mos.cms.futurecdn.net/FaWKMJQnr2PFcYCmEyfiTm-1200-80.jpg',
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      '제목' * 100,
      maxLines: 1,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

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
  const _Category();

  @override
  Widget build(BuildContext context) {
    return Text(
      '카테고리',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _UploadDate extends StatelessWidget {
  const _UploadDate();

  @override
  Widget build(BuildContext context) {
    return Text(
      '2024년 1월 1일',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[700],
          ),
    );
  }
}
