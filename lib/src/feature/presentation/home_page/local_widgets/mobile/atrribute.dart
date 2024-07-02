import 'package:flutter/material.dart';

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
      ],
    );
  }

  void _onSelectedMenu(String name) {
    setState(() {
      _selected = name;
    });
  }
}

class _MenuButton extends StatelessWidget {
  final String name;
  final MenuController controller;

  const _MenuButton({
    super.key,
    required this.name,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressedEvent,
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  void _onPressedEvent() {
    controller.isOpen ? _openMenu() : _closeMenu();
  }

  void _openMenu() {
    controller.close();
  }

  void _closeMenu() {
    controller.open();
  }
}

class _All extends StatelessWidget {
  final _SelectedMenu? onSelected;

  const _All({
    super.key,
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
    super.key,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SubmenuButton(
      menuChildren: List.generate(
        10,
        (index) => MenuItemButton(
          child: Text('카테고리 $index'),
          onPressed: () => onSelected?.call('카테고리 $index'),
        ),
      ),
      child: const Text('카테고리'),
    );
  }
}

class _Tags extends StatelessWidget {
  final _SelectedMenu? onSelected;

  const _Tags({
    super.key,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SubmenuButton(
      menuChildren: List.generate(
        10,
        (index) => MenuItemButton(
          child: Text('태그 $index'),
          onPressed: () => onSelected?.call('태그 $index'),
        ),
      ),
      child: const Text('태그'),
    );
  }
}
