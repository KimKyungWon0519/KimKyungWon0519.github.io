import 'package:kkw_blog/src/core/constants/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final GoTrueClient _auth = Supabase.instance.client.auth;

  User? get currentUser => _auth.currentUser;

  Future<bool> loginWithGithub(String redirectURL) async {
    return _auth.signInWithOAuth(
      OAuthProvider.github,
      redirectTo: redirectURL,
    );
  }

  Future<void> logout() async {
    return _auth.signOut(scope: SignOutScope.global);
  }

  bool isLogin() {
    return _auth.currentUser != null;
  }

  Future<User?> getUser(String uid) {
    SupabaseClient adminClient = SupabaseClient(supabaseUrl, supabaseRoleKey);

    return adminClient.auth.admin.getUserById(uid).then((value) => value.user);
  }
}
