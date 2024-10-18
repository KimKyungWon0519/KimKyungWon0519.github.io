abstract interface class SupabaseAuthRepository {
  Future<bool> loginWithGithub();
  bool isLogin();
}
