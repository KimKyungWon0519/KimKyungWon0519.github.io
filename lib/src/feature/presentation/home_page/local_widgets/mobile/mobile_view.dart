import 'package:flutter/material.dart';

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
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              const SliverToBoxAdapter(
                child: Header(),
              ),
              const SliverToBoxAdapter(
                child: TabBar(
                  tabs: [
                    Text('홈'),
                    Text('정보'),
                  ],
                ),
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Menu(),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: List.generate(
                            5,
                            (index) => const Placeholder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Placeholder(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
