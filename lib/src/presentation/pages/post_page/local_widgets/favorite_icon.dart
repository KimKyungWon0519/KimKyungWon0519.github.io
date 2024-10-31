import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    List<Favorite> favorite =
        ref.watch(postNotifierProvider.select((value) => value.favorites));
    bool isActiveFavorite = ref
        .read(postNotifierProvider.select((value) => value.isActiveFavorite));

    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
      onPressed: () async {
        showLoadingDialog(context);

        ResponseResult? responseResult;

        if (!isActiveFavorite) {
          responseResult =
              await ref.read(postNotifierProvider.notifier).activeFavorite();
        } else {
          responseResult =
              await ref.read(postNotifierProvider.notifier).deactiveFavorite();
        }

        context.pop();

        if (responseResult != null && responseResult.isSuccess) {
          ref.read(postNotifierProvider.notifier).updateFavorite();
        } else {
          String errorMsg = '';

          if (responseResult == null) {
            errorMsg = '로그인이 필요합니다.';
          } else {
            errorMsg = '추천 활성화/비활성화에 실패했습니다.';
          }

          showErrorDialog(
            context: context,
            errorMsg: errorMsg,
          );
        }
      },
      icon: Icon(isActiveFavorite
          ? Icons.favorite_rounded
          : Icons.favorite_border_rounded),
      label: Text('${favorite.length}'),
    );
  }
}
