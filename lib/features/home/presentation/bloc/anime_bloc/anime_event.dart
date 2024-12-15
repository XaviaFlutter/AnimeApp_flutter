part of 'anime_bloc.dart';

@immutable
sealed class AnimeEvent {}

class GetTagsEvent extends AnimeEvent {}

class GetStatusEvent extends AnimeEvent {}

class GetTypesEvent extends AnimeEvent {}

class AnimeLoadEvent extends AnimeEvent {}

class AnimeLoadNextPageEvent extends AnimeEvent {}

class AnimeFilterEvent extends AnimeEvent {
  final List<AnimeFilter>? filters;
  final String? query;

  AnimeFilterEvent({
    this.query,
    this.filters,
  });
}
