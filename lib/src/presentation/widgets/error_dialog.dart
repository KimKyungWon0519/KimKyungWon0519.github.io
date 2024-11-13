import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMsg;

  const ErrorDialog(this.errorMsg, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        Messages.of(context).error,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
      content: Text('$errorMsg\n\n${Messages.of(context).retry}'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(Messages.of(context).ok),
        ),
      ],
    );
  }
}

Future<T?> showErrorDialog<T>({
  required BuildContext context,
  required String errorMsg,
}) =>
    showDialog<T>(
      context: context,
      builder: (_) => ErrorDialog(errorMsg),
    );
