import 'package:flutter/material.dart';
import 'package:kkw_blog/src/core/constants/app_constant.dart';
import 'package:kkw_blog/src/feature/presentation/wigets/side_margin.dart';

import '../header.dart';
import '../preview.dart';
import 'atrribute.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return SideMargin(
      contentSize: 1200,
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
  }
}
