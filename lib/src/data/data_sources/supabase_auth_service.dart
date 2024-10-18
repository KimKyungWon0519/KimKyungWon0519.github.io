import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final GoTrueClient _auth = Supabase.instance.client.auth;

  Future<bool> loginWithGithub() async {
    return _auth.signInWithOAuth(OAuthProvider.github);
  }
}
