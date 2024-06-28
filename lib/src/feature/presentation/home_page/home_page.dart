import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './local_widgets/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ScreenTypeLayout.builder(
          desktop: (context) => Column(
            children: [
              SizedBox(
                width: size.width * (3 / 5),
                child: const Header(),
              ),
              const Expanded(
                child: Row(
                  children: [
                    Expanded(child: Placeholder()),
                    Expanded(
                      flex: 3,
                      child: Placeholder(),
                    ),
                    Spacer()
                  ],
                ),
              ),
            ],
          ),
          mobile: (context) => Column(
            children: [
              SizedBox(
                width: size.width,
                child: const Header(),
              ),
              const Expanded(child: Placeholder()),
            ],
          ),
        ),
      ),
    );
  }
}
