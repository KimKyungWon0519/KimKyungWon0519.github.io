import 'package:kkw_blog/src/domain/models/user.dart';

abstract interface class SupabaseAuthRepository {
  Future<bool> loginWithGithub(String redirectURL);
  Future<void> logout();
  bool isLogin();
  Future<User?> getUser(String uid);
}
