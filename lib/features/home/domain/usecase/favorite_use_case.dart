import 'package:anime_app/features/home/domain/entity/favorite_entity.dart';
import 'package:anime_app/features/home/domain/repository/favorite_repository.dart';

class AddFavoriteUseCase {
  final FavoriteRepository repository;

  AddFavoriteUseCase({required this.repository});

  Future<void> call(FavoriteEntity favorite) async {
    await repository.addFavorite(favorite);
  }
}

class RemoveFavoriteUseCase {
  final FavoriteRepository repository;

  RemoveFavoriteUseCase({required this.repository});

  Future<void> call(String favoriteId) async {
    await repository.removeFavorite(favoriteId);
  }
}

class GetFavoritesUseCase {
  final FavoriteRepository repository;

  GetFavoritesUseCase({required this.repository});

  Future<List<FavoriteEntity>> call() async {
    return await repository.getFavorites();
  }
}
