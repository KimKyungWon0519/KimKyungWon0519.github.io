abstract interface class SupabaseAuthRepository {
  Future<bool> loginWithGithub(String redirectURL);
  Future<void> logout();
  bool isLogin();
}
