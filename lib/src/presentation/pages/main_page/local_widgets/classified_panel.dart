import 'package:flutter/material.dart';

class ClassifiedPanel extends StatelessWidget {
  const ClassifiedPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _All(),
        _Categories(),
        _Tags(),
      ],
    );
  }
}

class _All extends StatelessWidget {
  const _All({super.key});

  @override
  Widget build(BuildContext context) {
    return _CustomListView(
      title: '전체보기 (10)',
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return _CustomExpansionTile(
      title: '카테고리',
      children: List.generate(
        10,
        (index) => _CustomListView(
          title: '카테고리 $index (10)',
        ),
      ),
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags({super.key});

  @override
  Widget build(BuildContext context) {
    return _CustomExpansionTile(
      title: '태그',
      children: List.generate(
        10,
        (index) => _CustomListView(
          title: '태그 $index (10)',
        ),
      ),
    );
  }
}

class _CustomListView extends StatelessWidget {
  final String title;

  const _CustomListView({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
    );
  }
}

class _CustomExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _CustomExpansionTile({
    super.key,
    required this.title,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTileTheme(
      data: ExpansionTileThemeData(
        shape: RoundedRectangleBorder(),
      ),
      child: ExpansionTile(
        title: Text(title),
        children: children,
      ),
    );
  }
}
