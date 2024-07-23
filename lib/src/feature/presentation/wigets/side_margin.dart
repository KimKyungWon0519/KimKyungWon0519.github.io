import 'package:flutter/material.dart';

class SideMargin extends StatelessWidget {
  final Widget? child;
  final int contentSize;

  const SideMargin({
    super.key,
    required this.child,
    this.contentSize = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double padding = (constraints.maxWidth - contentSize) / 2;

        if (padding < 0) padding = 0;

        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: padding,
          ),
          child: child,
        );
      },
    );
  }
}
