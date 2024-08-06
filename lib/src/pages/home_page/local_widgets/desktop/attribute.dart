import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kkw_blog/src/constants/app_constant.dart';
import 'package:kkw_blog/src/riverpods/post_notifier.dart';
import 'package:kkw_blog/src/utils/models/attribute_type.dart';

class Attribute extends StatelessWidget {
  const Attribute({super.key});

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
            _All(),
            _Categories(),
            _Tags(),
          ],
        ),
      ),
    );
  }
}

class _All extends ConsumerWidget {
  const _All({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _AttriTile(
      attributeType: AllAttri(),
      child: const Text(
        '전체보기',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Categories extends ConsumerWidget {
  const _Categories();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpansionTile(
      title: const Text(
        '카테고리',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: categories
          .map(
            (category) => _AttriTile(
              attributeType: CategoriesAttri(category),
              child: Text(category),
            ),
          )
          .toList(),
    );
  }
}

class _Tags extends ConsumerWidget {
  const _Tags();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpansionTile(
      title: const Text(
        '태그',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: tags
          .map(
            (tag) => _AttriTile(
              attributeType: TagsAttri(tag),
              child: Text(tag),
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

class _AttriTile extends ConsumerWidget {
  final Widget child;
  final AttributeType attributeType;

  const _AttriTile({
    super.key,
    required this.child,
    required this.attributeType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: child,
      onTap: () {
        ref.read(postNotifierProvider.notifier).update(attributeType);
      },
    );
  }
}
