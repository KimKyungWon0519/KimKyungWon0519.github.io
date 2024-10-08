import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/presentation/riverpods/classified_types_notifier.dart';
import 'package:kkw_blog/src/presentation/riverpods/main_notifier.dart';

typedef _SelectedMenu = void Function(ClassificationType);

class ClassifiedMenuButton extends ConsumerWidget {
  const ClassifiedMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ClassificationType type =
        ref.watch(mainNotifierProvider.select((value) => value.type));

    return MenuAnchor(
      menuChildren: [
        _All(onSelected: (type) => _onSelectedMenu(type, ref)),
        _Categories(onSelected: (type) => _onSelectedMenu(type, ref)),
        _Tags(onSelected: (type) => _onSelectedMenu(type, ref)),
      ],
      builder: (context, controller, child) {
        return _MenuButton(
          name: '$type',
          controller: controller,
        );
      },
    );
  }

  void _onSelectedMenu(ClassificationType type, WidgetRef ref) {
    ref.read(mainNotifierProvider.notifier).type = type;
    ref.read(mainNotifierProvider.notifier).updatePostsWithType(type);
  }
}

class _MenuButton extends StatefulWidget {
  final String name;
  final MenuController controller;

  const _MenuButton({
    required this.name,
    required this.controller,
  });

  @override
  State<_MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<_MenuButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Durations.short4);
    _animation =
        Tween<double>(begin: 0.0, end: 0.5).animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant _MenuButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!(widget.controller.isOpen) && _animation.value == 0.5) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _onPressedEvent,
      label: Text(
        widget.name,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      icon: RotationTransition(
        turns: _animation,
        child: const Icon(Icons.expand_more),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      iconAlignment: IconAlignment.end,
    );
  }

  void _onPressedEvent() {
    widget.controller.isOpen ? _closeMenu() : _openMenu();
  }

  void _openMenu() {
    _animationController.forward();
    widget.controller.open();
  }

  void _closeMenu() {
    _animationController.reverse();
    widget.controller.close();
  }
}

class _All extends ConsumerWidget {
  final _SelectedMenu? onSelected;

  const _All({
    this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<AllType> all = ref.watch(allTypeNotifierProvider);

    return all.when(
      data: (data) => MenuItemButton(
        onPressed: () => onSelected?.call(data),
        child: Text('$data'),
      ),
      error: (error, stackTrace) => const Text('전체보기 (0)'),
      loading: () => const Text('전체보기 (0)'),
    );
  }
}

class _Categories extends ConsumerWidget {
  final _SelectedMenu? onSelected;

  const _Categories({
    this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Set<CategoryType>> categories =
        ref.watch(categoriesNotifierProvider);

    return SubmenuButton(
      menuChildren: categories.when(
        data: (data) => data
            .map(
              (category) => MenuItemButton(
                child: Text('$category'),
                onPressed: () => onSelected?.call(category),
              ),
            )
            .toList(),
        error: (error, stackTrace) => [],
        loading: () => [],
      ),
      child: const Text('카테고리'),
    );
  }
}

class _Tags extends ConsumerWidget {
  final _SelectedMenu? onSelected;

  const _Tags({
    this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Set<TagType>> tags = ref.watch(tagsNotifierProvider);

    return SubmenuButton(
      menuChildren: tags.when(
        data: (data) => data
            .map(
              (tag) => MenuItemButton(
                child: Text('$tag'),
                onPressed: () => onSelected?.call(tag),
              ),
            )
            .toList(),
        error: (error, stackTrace) => [],
        loading: () => [],
      ),
      child: const Text('태그'),
    );
  }
}
