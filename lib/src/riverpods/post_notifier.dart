import 'package:kkw_blog/src/constants/app_constant.dart';
import 'package:kkw_blog/src/utils/models/attribute_type.dart';
import 'package:kkw_blog/src/utils/models/posts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_notifier.g.dart';

@riverpod
class PostNotifier extends _$PostNotifier {
  @override
  Posts build() => Posts([]);

  @override
  set state(Posts newPosts) => super.state = newPosts;

  void update(AttributeType type) {
    state = switch (type) {
      AllAttri() => posts,
      CategoriesAttri() => _categoryFilter(type.name),
      TagsAttri() => _tagFilter(type.name),
    };
  }

  Posts _categoryFilter(String category) {
    return Posts(posts.where((element) => element.catetory == category));
  }

  Posts _tagFilter(String tag) {
    return Posts(posts.where((element) => element.tags.contains(tag)));
  }
}
