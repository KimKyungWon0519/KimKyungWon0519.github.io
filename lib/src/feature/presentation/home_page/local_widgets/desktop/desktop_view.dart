import 'package:flutter/material.dart';

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
                        child: Placeholder(),
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
