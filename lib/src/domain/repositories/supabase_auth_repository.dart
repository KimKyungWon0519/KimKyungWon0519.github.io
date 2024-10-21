abstract interface class SupabaseAuthRepository {
  Future<bool> loginWithGithub(String redirectURL);
  bool isLogin();
}
