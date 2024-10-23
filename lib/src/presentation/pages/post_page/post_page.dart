import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/presentation/pages/post_page/local_widgets/comment_info.dart';
import 'package:kkw_blog/src/presentation/pages/post_page/local_widgets/comment_view.dart';
import 'package:kkw_blog/src/presentation/pages/post_page/local_widgets/markdown_view.dart';
import 'package:kkw_blog/src/presentation/riverpods/post_notifier.dart';
import 'package:kkw_blog/src/presentation/widgets/based_scroll_layout.dart';
import 'dart:html' as html;

import 'local_widgets/comment_field.dart';
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
      String? id = _getIDParameter();

      Future.delayed(Duration.zero).then(
        (value) {
          ref.read(postNotifierProvider.notifier).updatePost(
                post: this.post,
                fileName: id,
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

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints(maxWidth: 800),
        child: CustomScrollView(
          controller: scrollController,
          scrollBehavior:
              ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers: post != null
              ? [
                  const SliverToBoxAdapter(
                      child: SizedBox(height: kToolbarHeight)),
                  SliverToBoxAdapter(child: Header(post: post)),
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  const SliverToBoxAdapter(child: Divider()),
                  SliverToBoxAdapter(
                    child: MarkdownView(
                      id: post.id,
                      content: post.content,
                    ),
                  ),
                  const SliverPadding(
                    sliver: SliverToBoxAdapter(child: Divider()),
                    padding: EdgeInsets.symmetric(vertical: 32),
                  ),
                  SliverToBoxAdapter(
                    child: CommentField(
                      controller: commentScrollController,
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    sliver: SliverToBoxAdapter(
                      child: CommentInfo(),
                    ),
                  ),
                  const SliverToBoxAdapter(child: CommentView()),
                  const SliverToBoxAdapter(
                      child: SizedBox(height: kToolbarHeight)),
                ]
              : [],
        ),
      ),
    );
  }

  String? _getIDParameter() {
    Object? argument = ModalRoute.settingsOf(useContext())?.arguments;

    return argument != null ? (argument as Map<String, dynamic>)['id'] : null;
  }
}
