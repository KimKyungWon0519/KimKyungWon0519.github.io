import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
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

class _Categories extends ConsumerWidget {
  const _Categories();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Set<CategoryType>> categories =
        ref.watch(categoriesNotifierProvider);

    return _CustomExpansionTile(
      title: Messages.of(context).category,
      children: categories.when(
        data: (data) => data
            .map(
              (e) => _CustomListView(classificationType: e),
            )
            .toList(),
        error: (error, stackTrace) => [],
        loading: () => [],
      ),
    );
  }
}

class _Tags extends ConsumerWidget {
  const _Tags();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Set<TagType>> tags = ref.watch(tagsNotifierProvider);

    return _CustomExpansionTile(
      title: Messages.of(context).tag,
      children: tags.when(
        data: (data) => data
            .map(
              (e) => _CustomListView(classificationType: e),
            )
            .toList(),
        error: (error, stackTrace) => [],
        loading: () => [],
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
        ref
            .read(mainNotifierProvider.notifier)
            .updatePostsWithType(classificationType);
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
