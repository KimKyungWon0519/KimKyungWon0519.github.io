import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/resource/values/theme.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/presentation/riverpods/post_notifier.dart';
import 'package:kkw_blog/src/presentation/widgets/fab_panel.dart';
import 'package:kkw_blog/src/presentation/widgets/tags.dart';
import 'package:kkw_blog/src/presentation/widgets/upload_date_and_category.dart';

class PostPage extends HookConsumerWidget {
  final Post? post;

  const PostPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = useScrollController();

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

    Post? post = ref.watch(postNotifierProvider);

    return Title(
      color: Colors.white,
      title: post?.id ?? '',
      child: SelectionArea(
        child: Scaffold(
          body: Listener(
            onPointerSignal: (event) => _scrollingOutside(
              event,
              scrollController,
            ),
            child: RawScrollbar(
              trackColor: Colors.grey.withOpacity(.3),
              thumbVisibility: true,
              radius: const Radius.circular(30),
              controller: scrollController,
              thickness: 5,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: CustomScrollView(
                    controller: scrollController,
                    scrollBehavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    slivers: post != null
                        ? [
                            const SliverToBoxAdapter(
                                child: SizedBox(height: kToolbarHeight)),
                            SliverToBoxAdapter(
                              child: Text(
                                post.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            const SliverToBoxAdapter(
                                child: SizedBox(height: 8)),
                            SliverToBoxAdapter(
                              child: UploadDateAndCategory(
                                createAt: post.createAtToString,
                                category: post.category,
                              ),
                            ),
                            const SliverToBoxAdapter(
                                child: SizedBox(height: 8)),
                            SliverToBoxAdapter(
                              child: Tags(tags: post.tags),
                            ),
                            SliverToBoxAdapter(
                              child: Image.network(
                                post.thumbnail,
                                frameBuilder: (context, child, frame,
                                        wasSynchronouslyLoaded) =>
                                    Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: child,
                                ),
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox(),
                              ),
                            ),
                            const SliverToBoxAdapter(
                                child: SizedBox(height: 32)),
                            const SliverToBoxAdapter(child: Divider()),
                            SliverToBoxAdapter(
                              child: MarkdownBody(
                                styleSheet: customMarkdownStyleSheet(context),
                                data: post.content,
                                imageBuilder: (uri, title, alt) {
                                  String originUri = uri.path;
                                  Widget child;

                                  if (RegExp(r'.svg').hasMatch(originUri)) {
                                    child = SvgPicture.network(postBucketURL +
                                        '${post.id}/$originUri');
                                  } else {
                                    child = Image.network(postBucketURL +
                                        '${post.id}/$originUri');
                                  }

                                  return Container(
                                    margin: const EdgeInsets.all(16),
                                    alignment: Alignment.center,
                                    child: child,
                                  );
                                },
                              ),
                            ),
                            const SliverToBoxAdapter(
                                child: SizedBox(height: kToolbarHeight)),
                          ]
                        : [],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FabPanel(scrollController: scrollController),
        ),
      ),
    );
  }

  String? _getIDParameter() {
    Object? argument = ModalRoute.settingsOf(useContext())?.arguments;

    return argument != null ? (argument as Map<String, dynamic>)['id'] : null;
  }

  void _scrollingOutside(
    PointerSignalEvent event,
    ScrollController controller,
  ) {
    if (event is! PointerScrollEvent) {
      return;
    }

    double newPose = controller.offset + event.scrollDelta.dy;

    if (0 < newPose && newPose < controller.position.maxScrollExtent) {
      controller.jumpTo(controller.offset + event.scrollDelta.dy);
    }
  }
}
