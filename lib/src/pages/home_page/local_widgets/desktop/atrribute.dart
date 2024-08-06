import 'package:flutter/material.dart';
import 'package:kkw_blog/src/constants/app_constant.dart';

class Atrribute extends StatelessWidget {
  const Atrribute({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        expansionTileTheme: const ExpansionTileThemeData(
          shape: RoundedRectangleBorder(),
        ),
        listTileTheme: ListTileThemeData(
          titleTextStyle: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      child: const Padding(
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
  const _Categories();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        '카테고리',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: categories
          .map(
            (e) => ListTile(
              title: Text(e),
            ),
          )
          .toList(),
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        '태그',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: tags
          .map(
            (e) => ListTile(
              title: Text(e),
            ),
          )
          .toList(),
    );
  }
}

class _Informations extends StatelessWidget {
  const _Informations();

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text(
        '정보',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}