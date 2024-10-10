import 'package:flutter/material.dart';

class ScrollUpFab extends StatelessWidget {
  final VoidCallback? onPressed;

  const ScrollUpFab({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: const Text('맨 위로'),
      icon: const Icon(Icons.arrow_upward_rounded),
    );
  }
}
