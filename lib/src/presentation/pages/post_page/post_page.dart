import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/src/core/utils/seo.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/presentation/pages/post_page/local_widgets/comment_info.dart';
import 'package:kkw_blog/src/presentation/pages/post_page/local_widgets/comment_view.dart';
import 'package:kkw_blog/src/presentation/pages/post_page/local_widgets/markdown_view.dart';
import 'package:kkw_blog/src/presentation/pages/post_page/sliver_widgets/comment_listview.dart';
import 'package:kkw_blog/src/presentation/riverpods/post_notifier.dart';
import 'package:kkw_blog/src/presentation/widgets/based_scroll_layout.dart';
import 'package:kkw_blog/src/presentation/widgets/custom_header.dart';
import 'package:kkw_blog/src/presentation/widgets/loading_progress.dart';
import 'package:seo/seo.dart';
import 'dart:html' as html;

import 'local_widgets/comment_field.dart';
import 'local_widgets/favorite_icon.dart';
import 'local_widgets/header.dart';

class PostPage extends BasedScrollLayout {
  final Post? post;

  const PostPage({
    super.key,
    required this.post,
  });

  @override
  Widget childBuild(
    BuildContext context,
    WidgetRef ref,
    ScrollController scrollController,
    ObjectRef<bool> canScrolling,
  ) {
    final ScrollController commentScrollController = useScrollController();

    useEffect(() {
      String? routeID = _getIDParameter();

      Future.delayed(Duration.zero).then(
        (value) {
          ref.read(postNotifierProvider.notifier).updatePostAndComments(
                post: this.post,
                fileName: routeID,
              );
        },
      );

      return;
    }, []);

    useEffect(() {
      Timer lateChangeScrollState = Timer(Duration.zero, () {});

      void disableScrollController() {
        canScrolling.value = false;

        if (lateChangeScrollState.isActive) lateChangeScrollState.cancel();

        lateChangeScrollState = Timer(Durations.long2, () {
          canScrolling.value = true;
        });
      }

      commentScrollController.addListener(disableScrollController);

      return () =>
          commentScrollController.removeListener(disableScrollController);
    }, [commentScrollController]);

    Post? post = ref.watch(postNotifierProvider.select((value) => value.post));

    html.document.title = post?.title ?? '';

    String title = post?.title ?? '';
    String description = post?.content ?? '';
    String href = html.window.location.href;

    createMetaTag(title, description);
    createLinkTag(href);
    createOpenGraph(title, description, href);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: post == null
          ? const LoadingProgress()
          : Column(
              children: [
                Header(post: post),
                const SizedBox(height: 32),
                const Divider(),
                MarkdownView(
                  content: post.content,
                  routeID: post.routeID,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Divider(),
                ),
                const FavoriteIcon(),
                const SizedBox(height: 8),
                CommentField(controller: commentScrollController),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: CommentInfo(),
                ),
                const CommentListview(),
              ],
            ),
    );
  }

  String? _getIDParameter() {
    Object? argument = ModalRoute.settingsOf(useContext())?.arguments;

    return argument != null
        ? (argument as Map<String, dynamic>)['route_id']
        : null;
  }
}

class _LodingPost extends StatelessWidget {
  const _LodingPost({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingProgress();
  }
}
