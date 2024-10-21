import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kkw_blog/src/dependency_injection.dart';
import 'package:kkw_blog/src/domain/models/post.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_auth_repository.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_stroage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_notifier.g.dart';
part 'post_notifier.freezed.dart';

@riverpod
class PostNotifier extends _$PostNotifier {
  late final SupabaseStorageRepository _supabaseStorageRepository;
  late final SupabaseAuthRepository _supabaseAuthRepository;

  PostNotifier()
      : _supabaseStorageRepository = instance<SupabaseStorageRepository>(),
        _supabaseAuthRepository = instance<SupabaseAuthRepository>();

  @override
  PostNotifierState build() => PostNotifierState(
        post: null,
        isLogin: _supabaseAuthRepository.isLogin(),
      );

  set isLogin(bool value) => state = state.copyWith(isLogin: value);

  void updatePost({Post? post, String? fileName}) async {
    if (fileName == null) return;

    post ??= await _supabaseStorageRepository.getPostFile(fileName);

    state = state.copyWith(post: post);
  }

  Future<bool> loginWithGithub(String redirectURL) {
    return _supabaseAuthRepository.loginWithGithub(redirectURL);
  }

  Future<void> logout() {
    return _supabaseAuthRepository.logout();
  }
}

@freezed
class PostNotifierState with _$PostNotifierState {
  const factory PostNotifierState({
    required Post? post,
    required bool isLogin,
  }) = _PostNotifierState;
}
