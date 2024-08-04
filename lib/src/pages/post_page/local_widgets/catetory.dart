import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String text;

  const Category(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[700],
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
