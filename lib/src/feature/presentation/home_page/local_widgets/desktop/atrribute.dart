import 'package:flutter/material.dart';

class Atrribute extends StatelessWidget {
  const Atrribute({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExpansionTileTheme(
      data: ExpansionTileThemeData(
        shape: RoundedRectangleBorder(),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _Categories(),
            _Tags(),
            _Informations(),
          ],
        ),
      ),
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('카테고리'),
      children: List.generate(
        10,
        (index) => ListTile(
          title: Text('카테고리 아이템 $index'),
        ),
      ),
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('태그'),
      children: List.generate(
        10,
        (index) => ListTile(
          title: Text('태그 아이템 $index'),
        ),
      ),
    );
  }
}

class _Informations extends StatelessWidget {
  const _Informations({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(title: Text('정보'));
  }
}
