import 'package:kkw_blog/src/data/entities/favorite.dart' as Entity;
import 'package:kkw_blog/src/domain/models/favorite.dart' as Model;

extension FavoriteEntityMapper on Entity.Favorite {
  Model.Favorite toModel() {
    return Model.Favorite(
      id: id,
      uuid: uuid,
      postID: postID,
    );
  }
}

extension FavoriteModelMapper on Model.Favorite {
  Entity.Favorite toEntity() {
    return Entity.Favorite(
      id: id,
      uuid: uuid,
      postID: postID,
    );
  }
}
