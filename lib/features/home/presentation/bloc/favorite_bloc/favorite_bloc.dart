import 'package:anime_app/features/home/domain/entity/favorite_entity.dart';
import 'package:anime_app/features/home/domain/usecase/favorite_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final GetFavoritesUseCase getFavoritesUseCase;

  FavoriteCubit({
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.getFavoritesUseCase,
  }) : super(FavoriteLodaingState());

  Future<void> fetchFavorites() async {
    try {
      print(' fBloc ${getFavoritesUseCase.call()}');
      emit(FavoriteLodaingState());
      final favorites = await getFavoritesUseCase.call();
      emit(FavoriteLoadedState(favorites: favorites));
    } catch (e) {
      print('$e');
      emit(FavoriteErrorState('$e'));
    }
  }

  Future<void> removeFavorite(String favoriteId) async {
    try {
      emit(FavoriteLodaingState());
      final favorites = await removeFavoriteUseCase.call(favoriteId);
      fetchFavorites();
    } catch (e) {
      emit(FavoriteErrorState('$e'));
    }
  }

  Future<void> addFavorite(FavoriteEntity favorite) async {
    try {
      emit(FavoriteLodaingState());
      final favorites = await addFavoriteUseCase.call(favorite);
      fetchFavorites();
    } catch (e) {
      emit(FavoriteErrorState('$e'));
    }
  }

  bool isFavorite(String favoriteId) {
    if (state is FavoriteLoadedState) {
      final favorites = (state as FavoriteLoadedState).favorites;

      return favorites.any((favorite) {
        print('favorite.id ${favorite.id} == favoriteId $favoriteId');
        return favorite.title == favoriteId;
      });
    } else {
      return false;
    }
  }
}
