import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 4,
            width: MediaQuery.sizeOf(context).width * (3 / 5),
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
    );
  }
}
