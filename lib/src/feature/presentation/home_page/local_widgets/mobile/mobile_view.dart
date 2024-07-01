import 'package:flutter/material.dart';

import '../header.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Header(),
                TabBar(
                  tabs: [
                    Text('홈'),
                    Text('정보'),
                  ],
                ),
                MenuAnchor(
                  builder: (BuildContext context, MenuController controller,
                      Widget? child) {
                    return ElevatedButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      child: Text('전체'),
                    );
                  },
                  menuChildren: [
                    MenuItemButton(
                      child: Text('전체'),
                    ),
                    SubmenuButton(
                      menuChildren: List.generate(
                        10,
                        (index) => MenuItemButton(
                          child: Text('카테고리 $index'),
                        ),
                      ),
                      child: Text('카테고리'),
                    ),
                    SubmenuButton(
                      menuChildren: List.generate(
                        20,
                        (index) => MenuItemButton(
                          child: Text('태그 $index'),
                        ),
                      ),
                      child: Text('태그'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
