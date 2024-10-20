import 'package:kkw_blog/src/data/data_sources/supabase_auth_service.dart';
import 'package:kkw_blog/src/domain/repositories/supabase_auth_repository.dart';

class SupabaseAuthRepositoryImpl implements SupabaseAuthRepository {
  late final SupabaseAuthService _authService;

  SupabaseAuthRepositoryImpl({
    required SupabaseAuthService authService,
  }) : _authService = authService;

  @override
  Future<bool> loginWithGithub() {
    return _authService.loginWithGithub();
  }

  @override
  bool isLogin() {
    return _authService.isLogin();
  }
}