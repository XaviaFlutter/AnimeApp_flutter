import 'package:anime_app/features/home/domain/entity/anime_entity.dart';
import 'package:anime_app/features/home/domain/usecase/anime_filter_usecase.dart';
import 'package:anime_app/features/home/domain/usecase/get_anime_list_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

part 'anime_event.dart';
part 'anime_state.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final GetAllTypesUseCase _getAllTypesUseCase;
  final GetAllStatusUseCase _getAllStatusUseCase;
  final GetAnimeListUseCase _getAnimeListUseCase;
  final GetAllTagsUseCase _getAllTagsUseCase;
  final FilterAnimeUseCase _filterAnimeUseCase;
  List<AnimeEntity> _animeList = [];
  List<AnimeEntity> _filteredAnimeList = [];

  AnimeBloc({
    required GetAllStatusUseCase getAllStatusUseCase,
    required GetAllTypesUseCase getAllTypesUseCase,
    required GetAllTagsUseCase getAllTagsUseCase,
    required GetAnimeListUseCase getAnimeListUseCase,
    required FilterAnimeUseCase filterAnimeUseCase,
  })  : _getAnimeListUseCase = getAnimeListUseCase,
        _getAllStatusUseCase = getAllStatusUseCase,
        _filterAnimeUseCase = filterAnimeUseCase,
        _getAllTagsUseCase = getAllTagsUseCase,
        _getAllTypesUseCase = getAllTypesUseCase,
        super(AnimeInitial()) {
    on<AnimeLoadNextPageEvent>(_onGetNextPage);
    on<GetTypesEvent>(_onGetTypes);
    on<AnimeLoadEvent>(_onLoadAnime);
    on<AnimeFilterEvent>(_onFilterAnime);
    on<GetTagsEvent>(_onGetTags);
    on<GetStatusEvent>(_onGetStatus);
  }

  Future<void> _onGetNextPage(
      AnimeLoadNextPageEvent event, Emitter<AnimeState> emit) async {
    final currentState = state;
    if (currentState is AnimeLoadedState) {
      if (currentState.hasReachedMax) return;
      const int itemsPage = 20;
      final nextPage = currentState.currentPage + 1;
      final startIndex = (nextPage - 1) * itemsPage;
      final endIndex = startIndex + itemsPage;

      final nextItems = _animeList.sublist(startIndex,
          endIndex > _animeList.length ? _animeList.length : endIndex);
      emit(currentState.copyWith(
          animeList: currentState.animeList + nextItems,
          currentPage: nextPage,
          hasReachedMax: nextItems.isEmpty));
    }
  }

  Future<void> _onLoadAnime(
      AnimeLoadEvent event, Emitter<AnimeState> emit) async {
    emit(AnimeLoadingState());
    final currentState = state;
    try {
      const int itemsPage = 20;
      final initialItems = _animeList.take(itemsPage).toList();
      final animeLatest = await _getAnimeListUseCase.call();
      final animeList = await _getAnimeListUseCase.call();
      if (currentState is AnimeLoadedState) {
        emit(currentState.copyWith(
            animeList: initialItems,
            animeLatest: animeLatest,
            currentPage: 1,
            hasReachedMax: initialItems.length < itemsPage));
      } else {
        emit(AnimeLoadedState(
          animeLatest: animeLatest,
          animeList: animeList,
          tags: [],
        ));
      }
    } catch (e) {
      emit(AnimeFailureState(message: e.toString()));
    }
  }

  Future<void> _onGetStatus(
      GetStatusEvent event, Emitter<AnimeState> emit) async {
    try {
      final allStatus = await _getAllStatusUseCase();
      final currentState = state;

      if (currentState is AnimeLoadedState) {
        emit(currentState.copyWith(status: allStatus));
      } else {
        emit(AnimeLoadedState(
            animeList: [],
            animeLatest: [],
            tags: [],
            types: [],
            status: allStatus));
      }
    } catch (e) {
      AnimeFailureState(message: '$e');
    }
  }

  Future<void> _onGetTypes(
      GetTypesEvent event, Emitter<AnimeState> emit) async {
    try {
      final allTypes = await _getAllTypesUseCase();

      final currentState = state;

      if (currentState is AnimeLoadedState) {
        emit(currentState.copyWith(types: allTypes));
      } else {
        emit(AnimeLoadedState(
          animeList: [],
          animeLatest: [],
          tags: [],
          types: allTypes,
        ));
      }
    } catch (e) {
      emit(AnimeFailureState(message: 'getTypes $e'));
    }
  }

  Future<void> _onGetTags(GetTagsEvent event, Emitter<AnimeState> emit) async {
    try {
      final allTags = await _getAllTagsUseCase();
      final currentState = state;

      if (currentState is AnimeLoadedState) {
        emit(currentState.copyWith(tags: allTags));
      } else {
        emit(AnimeLoadedState(
          animeLatest: [],
          animeList: [],
          tags: allTags,
        ));
      }
    } catch (e) {
      print(e);
      emit(AnimeFailureState(message: '$e'));
    }
  }

  Future<void> _onFilterAnime(
      AnimeFilterEvent event, Emitter<AnimeState> emit) async {
    final currentState = state;
    try {
      final filteredAnimeList = await _filterAnimeUseCase.call(
          filtres: event.filters ?? [], query: event.query);
      if (currentState is AnimeLoadedState) {
        emit(currentState.copyWith(animeList: filteredAnimeList));
      } else {
        emit(AnimeLoadedState(
          animeLatest: [],
          animeList: filteredAnimeList,
          tags: [],
        ));
      }
    } catch (e) {
      emit(AnimeFailureState(message: e.toString()));
      print('AnimeFilterBloc $e');
    }
  }
}
