import 'package:kkw_blog/src/utils/models/posts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_notifier.g.dart';

@riverpod
class PostNotifier extends _$PostNotifier {
  @override
  Posts build() => Posts([]);

  @override
  set state(Posts newPosts) => super.state = newPosts;
}
