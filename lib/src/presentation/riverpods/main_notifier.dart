import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/dependency_injection.dart';
import 'package:kkw_blog/src/domain/models/classification_type.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_database_repository.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_stroage_repository.dart';
import 'package:kkw_blog/src/presentation/riverpods/classified_types_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_notifier.freezed.dart';
part 'main_notifier.g.dart';

@riverpod
class MainNotifier extends _$MainNotifier {
  late final SupabaseStorageRepository _supabaseStorageRepository;

  int _maxLength = 0;
  int _startOffset = 0;
  int? _categoryID;
  int? _tagID;

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

  Future<void> increaseStartOffset() async {
    if (_startOffset > _maxLength) return;

    _startOffset += 50;

    List<Post> posts = await _updatePosts();

    insertPost(posts);
  }

  set posts(List<Post> posts) => state = state.copyWith(posts: posts);
  void insertPost(List<Post> posts) {
    this.posts = state.posts.toList()..addAll(posts);
  }

  void updatePostsWithType(ClassificationType type) async {
    _startOffset = 0;
    _categoryID = null;
    _tagID = null;

    if (type case CategoryType()) {
      _categoryID = type.id;
    } else if (type case TagType()) {
      _tagID = type.id;
    }

    List<Post> posts = await _updatePosts();

    this.posts = posts;
  }

  void _initalizeState() {
    _initalizePosts();
    _initalizeType();
  }

  void _initalizePosts() {
    _updatePosts().then((value) => posts = value);
  }

  Future<List<Post>> _updatePosts() async {
    return _supabaseStorageRepository.getPostFiles(
      startOffset: _startOffset,
      tagID: _tagID,
      categoryID: _categoryID,
    );
  }

  void _initalizeType() {
    AsyncValue<AllType> type = ref.watch(allTypeNotifierProvider);

    type.whenData((data) {
      this.type = data;
      _maxLength = data.count;
    });
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
