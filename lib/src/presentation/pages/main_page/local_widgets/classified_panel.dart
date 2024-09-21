import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/presentation/riverpods/main_notifier.dart';

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
      classificationType: AllType(0),
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
          classificationType: CategoryType(
            category: '카테고리 $index',
            count: index * 2,
          ),
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
          classificationType: TagType(
            tag: '태그 $index',
            count: index * 3,
          ),
        ),
      ),
    );
  }
}

class _CustomListView<T> extends ConsumerWidget {
  final ClassificationType classificationType;

  const _CustomListView({
    super.key,
    required this.classificationType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ClassificationType type = ref.watch(mainNotifierProvider);

    bool isSelected = type == classificationType;

    return ListTile(
      title: Text(
        classificationType.name,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: () {
        ref.read(mainNotifierProvider.notifier).update(classificationType);
      },
    );
  }
}

class _CustomExpansionTile extends ConsumerWidget {
  final String title;
  final List<Widget> children;

  const _CustomExpansionTile({
    super.key,
    required this.title,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
