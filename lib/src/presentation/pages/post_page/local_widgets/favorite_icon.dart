import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/domain/models/favorite.dart';
import 'package:kkw_blog/src/presentation/riverpods/post_notifier.dart';

class FavoriteIcon extends ConsumerWidget {
  const FavoriteIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Favorite> favorite =
        ref.watch(postNotifierProvider.select((value) => value.favorites));

    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
      onPressed: () {},
      icon: const Icon(Icons.favorite_border_rounded),
      label: Text('${favorite.length}'),
    );
  }
}
