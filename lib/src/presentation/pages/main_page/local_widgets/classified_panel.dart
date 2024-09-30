import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/presentation/riverpods/classified_types_notifier.dart';
import 'package:kkw_blog/src/presentation/riverpods/main_notifier.dart';

class ClassifiedPanel extends StatelessWidget {
  const ClassifiedPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _All(),
        _Categories(),
        _Tags(),
      ],
    );
  }
}

class _All extends ConsumerWidget {
  const _All();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<AllType> allType = ref.watch(allTypeNotifierProvider);

    return allType.when(
      data: (data) => _CustomListView(classificationType: data),
      error: (error, stackTrace) => _default,
      loading: () => _default,
    );
  }

  Widget get _default => const _CustomListView(classificationType: AllType(0));
}

class _Categories extends StatelessWidget {
  const _Categories();

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
  const _Tags();

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
    ClassificationType type =
        ref.watch(mainNotifierProvider.select((value) => value.type));

    bool isSelected = type == classificationType;

    return ListTile(
      title: Text(
        '$classificationType',
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: () {
        ref.read(mainNotifierProvider.notifier).type = classificationType;
      },
    );
  }
}

class _CustomExpansionTile extends ConsumerWidget {
  final String title;
  final List<Widget> children;

  const _CustomExpansionTile({
    required this.title,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpansionTileTheme(
      data: const ExpansionTileThemeData(
        shape: RoundedRectangleBorder(),
      ),
      child: ExpansionTile(
        title: Text(title),
        children: children,
      ),
    );
  }
}
