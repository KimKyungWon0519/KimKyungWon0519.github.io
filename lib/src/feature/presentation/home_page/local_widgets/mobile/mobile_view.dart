import 'package:flutter/material.dart';

import '../preview.dart';
import '../header.dart';
import 'atrribute.dart';

class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Header(),
              const Align(
                alignment: Alignment.topLeft,
                child: Menu(),
              ),
              Divider(),
              ...List.generate(
                10,
                (index) => Preview(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
