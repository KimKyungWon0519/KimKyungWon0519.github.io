import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/core/utils/seo.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/presentation/pages/post_page/local_widgets/error_panel.dart';
import 'package:kkw_blog/src/presentation/riverpods/post_notifier.dart';
import 'package:kkw_blog/src/presentation/widgets/based_scroll_layout.dart';
import 'package:kkw_blog/src/presentation/widgets/loading_progress.dart';
import 'dart:html' as html;

import 'local_widgets/comment_field.dart';
import 'local_widgets/favorite_icon.dart';
import 'local_widgets/header.dart';
import 'local_widgets/comment_info.dart';
import 'local_widgets/markdown_view.dart';
import 'local_widgets/comment_listview.dart';

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

    AsyncValue<Post> post = ref.watch(postNotifierProvider
        .select((value) => value.post ?? const AsyncLoading()));

    post.whenData((value) {
      html.document.title = value.title;

      String title = value.title;
      String description = value.content;
      String href = html.window.location.href;

      createMetaTag(title, description);
      createLinkTag(href);
      createOpenGraph(title, description, href);
    });

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: post.when(
        data: (value) => Column(
          children: [
            Header(post: value),
            const SizedBox(height: 32),
            const Divider(),
            MarkdownView(
              content: value.content,
              routeID: value.routeID,
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
        error: (_, __) => SizedBox(
          height: getStaticBodySize(context),
          child: const ErrorPanel(),
        ),
        loading: () => SizedBox(
          height: getStaticBodySize(context),
          child: const LoadingProgress(),
        ),
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
