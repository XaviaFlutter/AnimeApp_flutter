import 'dart:convert';

import 'package:anime_app/features/home/data/dto/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoriteLocalDataSource {
  Future<void> addFavorite(FavoriteModel favoriteModel);
  Future<void> removeFavorite(String favoriteId);
  Future<List<FavoriteModel>> getFavorites();
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoriteLocalDataSourceImpl(this.sharedPreferences);
  static const _favoritesKey = 'favorites';

  @override
  Future<void> addFavorite(FavoriteModel favoriteModel) async {
    final favorites = sharedPreferences.getStringList(_favoritesKey) ?? [];
    final jsonFavorite = jsonEncode(favoriteModel.toJson());
    if (!favorites.contains(jsonFavorite)) {
      favorites.add(jsonFavorite);
      await sharedPreferences.setStringList(_favoritesKey, favorites);
    }
  }

  @override
  Future<void> removeFavorite(String favoriteId) async {
    final favorites = sharedPreferences.getStringList(_favoritesKey) ?? [];
    favorites.removeWhere((item) {
      final favorite = FavoriteModel.fromJson(jsonDecode(item));
      return favorite.id == favoriteId;
    });
    await sharedPreferences.setStringList(_favoritesKey, favorites);
  }

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    final favorites = sharedPreferences.getStringList(_favoritesKey) ?? [];
    print('$favorites');
    return favorites
        .map((item) => FavoriteModel.fromJson(jsonDecode(item)))
        .toList();
  }
}
