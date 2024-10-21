import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final GoTrueClient _auth = Supabase.instance.client.auth;

  Future<bool> loginWithGithub(String redirectURL) async {
    return _auth.signInWithOAuth(
      OAuthProvider.github,
      redirectTo: redirectURL,
    );
  }

  bool isLogin() {
    return _auth.currentUser != null;
  }
}
