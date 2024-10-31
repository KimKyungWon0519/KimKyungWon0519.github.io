import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/core/utils/response_result.dart';
import 'package:kkw_blog/src/domain/models/favorite.dart';
import 'package:kkw_blog/src/dependency_injection.dart';
import 'package:kkw_blog/src/domain/models/comment.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/domain/models/user.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_auth_repository.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_database_repository.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_stroage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_notifier.g.dart';
part 'post_notifier.freezed.dart';

@riverpod
class PostNotifier extends _$PostNotifier {
  late final SupabaseStorageRepository _supabaseStorageRepository;
  late final SupabaseAuthRepository _supabaseAuthRepository;
  late final SupabaseDatabaseRepository _supabaseDatabaseRepository;

  PostNotifier()
      : _supabaseStorageRepository = instance<SupabaseStorageRepository>(),
        _supabaseAuthRepository = instance<SupabaseAuthRepository>(),
        _supabaseDatabaseRepository = instance<SupabaseDatabaseRepository>();

  @override
  PostNotifierState build() => PostNotifierState(
        user: _supabaseAuthRepository.currentUser,
      );

  void updatePostAndComments({Post? post, String? fileName}) async {
    if (fileName == null) return;

    post ??= await _supabaseStorageRepository.getPostFile(fileName);
    List<Comment> comments =
        await _supabaseDatabaseRepository.getComments(post.id);
    List<Favorite> favorites =
        await _supabaseDatabaseRepository.getFavorites(post.id);

    state = state.copyWith(
      post: post,
      comments: comments,
      favorites: favorites,
    );
  }

  Future<bool> loginWithGithub(String redirectURL) {
    return _supabaseAuthRepository.loginWithGithub(redirectURL);
  }

  Future<void> logout() {
    return _supabaseAuthRepository.logout();
  }

  void updateUser() async {
    User? user = _supabaseAuthRepository.currentUser;

    state = state.copyWith(user: user);
  }

  Future<ResponseResult?> submitComment(String content) async {
    if (state.post == null || !state.isLogin) return null;

    Comment comment = Comment(
      user: state.user!,
      content: content,
      postID: state.post!.id,
    );

    return _supabaseDatabaseRepository.saveComment(comment);
  }

  Future<ResponseResult?> activeFavorite() async {
    if (state.post == null || !state.isLogin) return null;

    Favorite favorite = Favorite(
      uuid: state.user!.uuid,
      postID: state.post!.id,
    );

    return _supabaseDatabaseRepository.activeFavorite(favorite);
  }

  Future<ResponseResult?> deactiveFavorite() async {
    if (state.post == null) return null;

    return _supabaseDatabaseRepository.deactiveFavorite(state.post!.id);
  }

  void updateComment() async {
    List<Comment> comments =
        await _supabaseDatabaseRepository.getComments(state.post!.id);

    state = state.copyWith(comments: comments);
  }

  void updateFavorite() async {
    List<Favorite> favorites =
        await _supabaseDatabaseRepository.getFavorites(state.post!.id);

    state = state.copyWith(favorites: favorites);
  }
}

@freezed
class PostNotifierState with _$PostNotifierState {
  const PostNotifierState._();

  const factory PostNotifierState({
    Post? post,
    User? user,
    @Default([]) List<Comment> comments,
    @Default([]) List<Favorite> favorites,
  }) = _PostNotifierState;

  bool get isLogin => user != null;

  bool get isActiveFavorite =>
      favorites.indexWhere(
          (element) => user != null && user!.uuid == element.uuid) !=
      -1;
}
