import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      UploadDateAndCategory(
                        createAt: post.createAtToString,
                        category: post.category,
                      ),
                      const SizedBox(height: 8),
                      Tags(tags: post.tags),
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
