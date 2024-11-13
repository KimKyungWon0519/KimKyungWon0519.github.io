import 'package:kkw_blog/src/data/data_sources/supabase_auth_service.dart';
import 'package:kkw_blog/src/data/mappers/user_mapper.dart';
import 'package:kkw_blog/src/domain/models/user.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_auth_repository.dart';

class SupabaseAuthRepositoryImpl implements SupabaseAuthRepository {
  late final SupabaseAuthService _authService;

  SupabaseAuthRepositoryImpl({
    required SupabaseAuthService authService,
  }) : _authService = authService;

  @override
  Future<bool> loginWithGithub(String redirectURL) {
    return _authService.loginWithGithub(redirectURL);
  }

  @override
  Future<void> logout() {
    return _authService.logout();
  }

  @override
  bool isLogin() {
    return _authService.isLogin();
  }

  @override
  Future<User?> getUser(String uid) {
    return _authService.getUser(uid).then((value) => value?.toModel());
  }

  @override
  User? get currentUser => _authService.currentUser?.toModel();
}
