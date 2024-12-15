import 'package:anime_app/features/home/data/dto/favorite_model.dart';
import 'package:anime_app/features/home/data/sources/favorite_local_data_source.dart';
import 'package:anime_app/features/home/domain/entity/favorite_entity.dart';
import 'package:anime_app/features/home/domain/repository/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource localDataSource;

  FavoriteRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addFavorite(FavoriteEntity favorite) async {
    final favoriteModel = FavoriteModel(
        year: favorite.year,
        season: favorite.season,
        tags: favorite.tags,
        status: favorite.status,
        episode: favorite.episode,
        type: favorite.type,
        id: favorite.id,
        title: favorite.title,
        picture: favorite.picture);
    await localDataSource.addFavorite(favoriteModel);
  }

  @override
  Future<void> removeFavorite(String favoriteId) async {
    await localDataSource.removeFavorite(favoriteId);
  }

  @override
  Future<List<FavoriteEntity>> getFavorites() async {
    final favoriteModel = await localDataSource.getFavorites();
    return favoriteModel;
  }
}
