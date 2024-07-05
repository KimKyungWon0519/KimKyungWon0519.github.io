import 'package:flutter/material.dart';
import 'package:kkw_blog/src/feature/presentation/home_page/local_widgets/desktop/preview.dart';

import '../header.dart';
import 'atrribute.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double padding = (constraints.maxWidth - 1200) / 2;

            if (padding < 0) padding = 0;

            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: padding,
              ),
              child: const Column(
                children: [
                  Header(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Atrribute(),
                      ),
                      Expanded(
                        flex: 3,
                        child: Preview(),
                      ),
                      Spacer()
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
