import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/resource/values/theme.dart';
import 'package:kkw_blog/src/core/constants/supabase.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/presentation/riverpods/post_notifier.dart';
import 'package:kkw_blog/src/presentation/widgets/tags.dart';
import 'package:kkw_blog/src/presentation/widgets/theme_mode_fab.dart';
import 'package:kkw_blog/src/presentation/widgets/upload_date_and_category.dart';

class PostPage extends HookConsumerWidget {
  final Post? post;

  const PostPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      title: post?.title ?? '',
      color: Colors.white,
      child: Scaffold(
        body: post != null
            ? Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: kToolbarHeight,
                  ),
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Text(
                          post.title,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 8)),
                      SliverToBoxAdapter(
                        child: UploadDateAndCategory(
                          createAt: post.createAtToString,
                          category: post.category,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 8)),
                      SliverToBoxAdapter(
                        child: Tags(tags: post.tags),
                      ),
                      SliverToBoxAdapter(
                        child: Image.network(
                          post.thumbnail,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) =>
                                  Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: child,
                          ),
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox(),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 32)),
                      const SliverToBoxAdapter(child: Divider()),
                      SliverToBoxAdapter(
                        child: MarkdownBody(
                          styleSheet: customMarkdownStyleSheet(context),
                          data: post.content,
                          imageBuilder: (uri, title, alt) {
                            String originUri = uri.path;
                            Widget child;

                            if (RegExp(r'.svg').hasMatch(originUri)) {
                              child = SvgPicture.network(
                                  postBucketURL + '${post.id}/$originUri');
                            } else {
                              child = Image.network(
                                  postBucketURL + '${post.id}/$originUri');
                            }

                            return Container(
                              margin: const EdgeInsets.all(16),
                              alignment: Alignment.center,
                              child: child,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
        floatingActionButton: const ThemeModeFab(),
      ),
    );
  }

  String? _getIDParameter() {
    Object? argument = ModalRoute.settingsOf(useContext())?.arguments;

    return argument != null ? (argument as Map<String, dynamic>)['id'] : null;
  }
}
