import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kkw_blog/src/constants/app_constant.dart';
import 'package:kkw_blog/src/riverpods/post_notifier.dart';
import 'package:kkw_blog/src/utils/models/attribute_type.dart';

typedef _SelectedMenu = void Function(String, AttributeType);

class Menu extends ConsumerStatefulWidget {
  const Menu({super.key});

  @override
  ConsumerState<Menu> createState() => _MenuState();
}

class _MenuState extends ConsumerState<Menu> {
  String _selected = '전체';

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (
        BuildContext context,
        MenuController controller,
        Widget? child,
      ) =>
          _MenuButton(
        name: _selected,
        controller: controller,
      ),
      menuChildren: [
        _All(onSelected: _onSelectedMenu),
        _Categories(onSelected: _onSelectedMenu),
        _Tags(onSelected: _onSelectedMenu),
      ],
    );
  }

  void _onSelectedMenu(
    String name,
    AttributeType attr,
  ) {
    ref.read(postNotifierProvider.notifier).update(attr);

    setState(() {
      _selected = name;
    });
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

class _All extends StatelessWidget {
  final _SelectedMenu? onSelected;

  const _All({
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: () => onSelected?.call('전체', AllAttri()),
      child: const Text('전체'),
    );
  }
}

class _Categories extends StatelessWidget {
  final _SelectedMenu? onSelected;

  const _Categories({
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SubmenuButton(
      menuChildren: categories
          .map(
            (category) => MenuItemButton(
              child: Text(category),
              onPressed: () =>
                  onSelected?.call(category, CategoriesAttri(category)),
            ),
          )
          .toList(),
      child: const Text('카테고리'),
    );
  }
}

class _Tags extends StatelessWidget {
  final _SelectedMenu? onSelected;

  const _Tags({
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SubmenuButton(
      menuChildren: tags
          .map(
            (tag) => MenuItemButton(
              child: Text(tag),
              onPressed: () => onSelected?.call(tag, TagsAttri(tag)),
            ),
          )
          .toList(),
      child: const Text('태그'),
    );
  }
}

class _Information extends StatelessWidget {
  final _SelectedMenu? onSelected;

  const _Information({
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: () {},
      child: const Text('정보'),
    );
  }
}
