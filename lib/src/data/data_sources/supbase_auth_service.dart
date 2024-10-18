import 'package:supabase_flutter/supabase_flutter.dart';

class SupbaseAuthService {
  final GoTrueClient auth = Supabase.instance.client.auth;
}
