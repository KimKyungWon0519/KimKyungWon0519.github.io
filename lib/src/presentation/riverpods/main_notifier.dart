import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/dependency_injection.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_stroage_repository.dart';
import 'package:kkw_blog/src/presentation/riverpods/classified_types_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_notifier.freezed.dart';
part 'main_notifier.g.dart';

@riverpod
class MainNotifier extends _$MainNotifier {
  late final SupabaseStorageRepository _supabaseStorageRepository;

  MainNotifier()
      : _supabaseStorageRepository = instance<SupabaseStorageRepository>();

  @override
  MainNotifierState build() {
    Future.delayed(Durations.long2).then((_) => _initalizeState());

    return MainNotifierState.empty();
  }

  set type(ClassificationType type) {
    state = state.copyWith(type: type);
  }

  set posts(List<Post> posts) => state = state.copyWith(posts: posts);

  void updatePostsWithType(ClassificationType type) {
    switch (type) {
      case AllType():
        _updatePosts();

        break;
      case CategoryType():
        _updatePosts(categoryID: type.id);

        break;
      case TagType():
        _updatePosts(tagID: type.id);

        break;
    }
  }

  void _initalizeState() {
    _updatePosts();
    _initalizeType();
  }

  Future<void> _updatePosts({
    int? categoryID,
    int? tagID,
  }) async {
    List<Post> posts = await _supabaseStorageRepository.getPostFiles(
      tagID: tagID,
      categoryID: categoryID,
    );

    this.posts = posts;
  }

  void _initalizeType() {
    AsyncValue<AllType> type = ref.watch(allTypeNotifierProvider);

    type.whenData((data) => this.type = data);
  }
}

@freezed
class MainNotifierState with _$MainNotifierState {
  const factory MainNotifierState({
    required ClassificationType type,
    required List<Post> posts,
  }) = _MainNotifierState;

  factory MainNotifierState.empty() => const MainNotifierState(
        type: AllType(0),
        posts: [],
      );
}
