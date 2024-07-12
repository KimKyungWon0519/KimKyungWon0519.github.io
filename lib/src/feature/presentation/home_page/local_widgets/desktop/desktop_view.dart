import 'package:flutter/material.dart';
import 'package:kkw_blog/src/core/constants/app_constant.dart';

import '../header.dart';
import '../preview.dart';
import 'atrribute.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({super.key});

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
          child: Column(
            children: [
              const Header(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Atrribute(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: posts
                            .map(
                              (post) => Preview(
                                post: post,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
