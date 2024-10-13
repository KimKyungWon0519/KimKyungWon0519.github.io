import 'package:flutter/material.dart';

class CommentField extends StatelessWidget {
  const CommentField({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Container(
      height: height * 0.25,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const _InputField(),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField();

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.primaryContainer;

    return TextField(
      expands: true,
      maxLines: null,
      maxLength: 500,
      cursorColor: color,
      style: TextStyle(color: color),
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        counterStyle: TextStyle(color: color),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
      ),
    );
  }
}
