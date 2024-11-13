import 'package:flutter/material.dart';

import 'classified_menu_button.dart';
import '../header.dart';
import '../preview_listview.dart';

class Lyaout extends StatelessWidget {
  final ScrollController scrollController;

  const Lyaout({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Header(),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: ClassifiedMenuButton(),
        ),
        PreviewListview(),
      ],
    );
  }
}
