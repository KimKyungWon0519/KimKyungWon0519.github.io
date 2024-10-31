import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/src/core/utils/response_result.dart';
import 'package:kkw_blog/src/domain/models/favorite.dart';
import 'package:kkw_blog/src/presentation/pages/post_page/local_widgets/comment_field.dart';
import 'package:kkw_blog/src/presentation/riverpods/post_notifier.dart';
import 'package:kkw_blog/src/presentation/widgets/error_dialog.dart';
import 'package:kkw_blog/src/presentation/widgets/loading_dialog.dart';

class FavoriteIcon extends ConsumerWidget {
  const FavoriteIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _FavoriteIconState favoriteState = ref.watch(
      postNotifierProvider.select(
        (value) => _FavoriteIconState(
            favorite: value.favorites,
            isActiveFavorite: value.isActiveFavorite),
      ),
    );

    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
      onPressed: () => _onPressedEvent(context, ref, favoriteState),
      icon: Icon(favoriteState.isActiveFavorite
          ? Icons.favorite_rounded
          : Icons.favorite_border_rounded),
      label: Text('${favoriteState.favorite.length}'),
    );
  }

  void _onPressedEvent(
    BuildContext context,
    WidgetRef ref,
    _FavoriteIconState favoriteState,
  ) async {
    PostNotifier postNotifier = ref.read(postNotifierProvider.notifier);

    showLoadingDialog(context);

    ResponseResult? responseResult;

    if (!favoriteState.isActiveFavorite) {
      responseResult = await postNotifier.activeFavorite();
    } else {
      responseResult = await postNotifier.deactiveFavorite();
    }

    context.pop();

    if (responseResult != null && responseResult.isSuccess) {
      postNotifier.updateFavorite();
    } else {
      String errorMsg = '';

      if (responseResult == null) {
        errorMsg = Messages.of(context).neededLogin;
      } else {
        errorMsg = Messages.of(context).failureChaningFavorite;
      }

      showErrorDialog(
        context: context,
        errorMsg: errorMsg,
      );
    }
  }
}

class _FavoriteIconState {
  final List<Favorite> favorite;
  final bool isActiveFavorite;

  const _FavoriteIconState({
    required this.favorite,
    required this.isActiveFavorite,
  });
}
