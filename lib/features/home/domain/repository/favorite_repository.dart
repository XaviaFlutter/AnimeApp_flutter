import 'package:anime_app/features/home/domain/entity/favorite_entity.dart';

abstract class FavoriteRepository {
  Future<void> addFavorite(FavoriteEntity favorite);
  Future<void> removeFavorite(String favoriteId);
  Future<List<FavoriteEntity>> getFavorites();
}
