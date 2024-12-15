part of 'anime_bloc.dart';

@immutable
sealed class AnimeState {}

final class AnimeInitial extends AnimeState {}

final class AnimeLoadedState extends AnimeState {
  final List<AnimeEntity> animeList;
  final List<AnimeEntity> animeLatest;
  final List<String> tags;
  final List<String> types;
  final List<String> status;
  final List<AnimeEntity> currentList;
  final int currentPage;
  final bool hasReachedMax;
  AnimeLoadedState(
      {required this.animeList,
      required this.animeLatest,
      this.currentPage = 1,
      this.hasReachedMax = false,
      this.currentList = const [],
      this.status = const [],
      this.tags = const [],
      this.types = const []});
  AnimeLoadedState copyWith(
      {List<AnimeEntity>? currentList,
      List<AnimeEntity>? animeList,
      List<AnimeEntity>? animeLatest,
      List<String>? tags,
      List<String>? types,
      List<String>? status,
      int? currentPage,
      bool? hasReachedMax}) {
    return AnimeLoadedState(
        currentPage: currentPage ?? this.currentPage,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        currentList: currentList ?? this.currentList,
        animeLatest: animeLatest ?? this.animeLatest,
        animeList: animeList ?? this.animeList,
        status: status ?? this.status,
        tags: tags ?? this.tags,
        types: types ?? this.types);
  }
}

final class AnimeLoadingState extends AnimeState {}

final class AnimeFailureState extends AnimeState {
  final String message;

  AnimeFailureState({required this.message});
}
