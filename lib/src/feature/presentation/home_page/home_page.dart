import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'local_widgets/desktop/desktop_view.dart';
import 'local_widgets/mobile/mobile_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => const DesktopView(),
      mobile: (context) => const MobileView(),
    );
  }
}
