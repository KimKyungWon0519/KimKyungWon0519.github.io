import 'package:flutter/material.dart';

class Preview extends StatelessWidget {
  const Preview({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: _addSpacing(
            [
              const _UploadDateAndCategory(),
              _Thumbnail(height: constraints.maxWidth * 0.5),
              const _Content(),
              const Align(
                alignment: Alignment.topLeft,
                child: _Tags(),
              )
            ],
          ),
        );
      },
    );
  }

  List<Widget> _addSpacing(List<Widget> children) {
    return children
        .expand(
          (element) => [
            element,
            const SizedBox(height: 8),
          ],
        )
        .toList()
      ..removeLast();
  }
}

class _UploadDateAndCategory extends StatelessWidget {
  const _UploadDateAndCategory();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const Text('2024년 9월 15일'),
          const VerticalDivider(),
          Text(
            '카테고리 1',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final double height;

  const _Thumbnail({
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://images-assets.nasa.gov/image/PIA00122/PIA00122~small.jpg',
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '블로그 제목' * 100,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        Text(
          '내용' * 1000,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: List.filled(
        50,
        Text(
          '#태그',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
      ),
    );
  }
}
