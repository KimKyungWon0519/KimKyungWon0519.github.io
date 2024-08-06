import 'package:flutter/material.dart';

class ScrollToTopFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const ScrollToTopFAB({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.keyboard_arrow_up_rounded),
    );
  }
}
