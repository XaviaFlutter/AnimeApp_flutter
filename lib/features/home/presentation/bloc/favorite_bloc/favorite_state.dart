part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitialState extends FavoriteState {}

final class FavoriteLodaingState extends FavoriteState {}

final class FavoriteLoadedState extends FavoriteState {
  final List<FavoriteEntity> favorites;

  FavoriteLoadedState({required this.favorites});
}

final class FavoriteErrorState extends FavoriteState {
  final String message;

  FavoriteErrorState(this.message);
}
