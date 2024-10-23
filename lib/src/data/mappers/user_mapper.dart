import 'package:supabase_flutter/supabase_flutter.dart' as Entity;
import 'package:kkw_blog/src/domain/models/user.dart' as Model;

extension UserEntityMapper on Entity.User {
  Model.User toModel() {
    return Model.User(
      uuid: id,
      userName: userMetadata?['preferred_username'] ?? '',
      avatar: userMetadata?['avatar_url'] ?? '',
    );
  }
}
