import 'package:kkw_blog/src/domain/models/user.dart';

abstract interface class SupabaseAuthRepository {
  User? get currentUser;
  Future<bool> loginWithGithub(String redirectURL);
  Future<void> logout();
  bool isLogin();
  Future<User?> getUser(String uid);
}
