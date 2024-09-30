import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/presentation/riverpods/main_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'classified_types_notifier.g.dart';

@riverpod
AllType allTypeNotifier(AllTypeNotifierRef ref) {
  List<Post> posts =
      ref.watch(mainNotifierProvider.select((value) => value.posts));

  return AllType(posts.length);
}

@riverpod
Set<CategoryType> categoriesNotifier(CategoriesNotifierRef ref) {
  return {};
}

@riverpod
Set<TagType> tagsNotifier(TagsNotifierRef ref) {
  return {};
}
