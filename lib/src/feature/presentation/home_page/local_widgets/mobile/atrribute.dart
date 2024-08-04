import 'package:flutter/material.dart';
import 'package:kkw_blog/src/core/constants/app_constant.dart';

typedef _SelectedMenu = void Function(String);

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
        _Information(onSelected: _onSelectedMenu),
      ],
    );
  }

  void _onSelectedMenu(String name) {
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
    widget.controller.isOpen ? _openMenu() : _closeMenu();
  }

  void _openMenu() {
    _animationController.reverse();
    widget.controller.close();
  }

  void _closeMenu() {
    _animationController.forward();
    widget.controller.open();
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
      onPressed: () => onSelected?.call('전체'),
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
            (e) => MenuItemButton(
              child: Text(e),
              onPressed: () => onSelected?.call(e),
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
            (e) => MenuItemButton(
              child: Text(e),
              onPressed: () => onSelected?.call(e),
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
      onPressed: () => onSelected?.call('정보'),
      child: const Text('정보'),
    );
  }
}
