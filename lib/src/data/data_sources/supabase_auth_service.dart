import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final GoTrueClient auth = Supabase.instance.client.auth;

  Future<bool> loginWithGithub() async {
    return auth.signInWithOAuth(OAuthProvider.github);
  }
}
