import 'package:flutter/material.dart';

class SideMargin extends StatelessWidget {
  final Widget? child;

  const SideMargin({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double padding = (constraints.maxWidth - 1200) / 2;

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
