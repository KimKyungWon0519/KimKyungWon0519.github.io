import 'package:flutter/material.dart';

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

void showLoadingDialog(BuildContext context) => showDialog(
      context: context,
      builder: (_) => const LoadingProgress(),
      barrierDismissible: false,
    );
