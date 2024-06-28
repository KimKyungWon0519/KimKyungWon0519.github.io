import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ScreenTypeLayout.builder(
          desktop: (p0) => Column(
            children: [
              SizedBox(
                height: size.height / 4,
                width: size.width * (3 / 5),
                child: const Placeholder(),
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
          mobile: (p0) => Column(
            children: [
              SizedBox(
                height: size.height / 4,
                width: size.width,
                child: const Placeholder(),
              ),
              const Expanded(child: Placeholder()),
            ],
          ),
        ),
      ),
    );
  }
}
