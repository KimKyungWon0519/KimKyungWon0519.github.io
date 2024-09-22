import 'package:flutter/material.dart';
import 'package:kkw_blog/src/presentation/pages/main_page/local_widgets/preview.dart';

class PreviewListview extends StatelessWidget {
  const PreviewListview({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> previews = List.generate(
      50,
      (index) => const Preview(),
    );

    return SliverList.list(
      children: _addDivider(previews),
    );
  }

  List<Widget> _addDivider(List<Widget> previews) {
    int length = previews.length;

    for (int i = 0; i < length * 2 + 1; i += 2) {
      previews.insert(
        i,
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            thickness: 2,
          ),
        ),
      );
    }

    return previews;
  }
}
