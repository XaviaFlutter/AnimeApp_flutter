import 'package:anime_app/features/home/domain/entity/anime_entity.dart';
import 'package:anime_app/features/home/domain/repository/anime_repository.dart';
import 'package:anime_app/features/home/domain/usecase/anime_filter_usecase.dart';

class GetAnimeListUseCase {
  final AnimeRepository repository;

  GetAnimeListUseCase(this.repository);

  Future<List<AnimeEntity>> call() async {
    final animeList = await repository.getAnimeList();
    animeList.sort((a, b) => b.animeSeason.year.compareTo(a.animeSeason.year));
    return animeList;
  }
}

class GetAllStatusUseCase {
  final AnimeRepository repository;

  GetAllStatusUseCase(this.repository);

  Future<List<String>> call() async {
    final animeList = await repository.getAnimeList();

    final allStatus = <String>{};
    for (final anime in animeList) {
      allStatus.add(anime.status);
    }

    return allStatus.toList();
  }
}

class GetAllTagsUseCase {
  final AnimeRepository repository;

  GetAllTagsUseCase(this.repository);

  Future<List<String>> call() async {
    final animeList = await repository.getAnimeList();

    final allTags = <String>{};
    for (final anime in animeList) {
      allTags.addAll(anime.tags);
    }

    return allTags.toList();
  }
}

class GetAllTypesUseCase {
  final AnimeRepository repository;

  GetAllTypesUseCase(this.repository);

  Future<List<String>> call() async {
    final animeList = await repository.getAnimeList();

    final allTypes = <String>{};
    for (final anime in animeList) {
      allTypes.add(anime.type);
    }

    return allTypes.toList();
  }
}

class GetRecentlyAnimeListUseCase {
  final AnimeRepository repository;

  GetRecentlyAnimeListUseCase({required this.repository});

  Future<List<AnimeEntity>> call() async {
    final animeList = await repository.getAnimeList();
    return animeList;
  }
}

class FilterAnimeUseCase {
  final AnimeRepository repository;

  FilterAnimeUseCase(this.repository);

  Future<List<AnimeEntity>> call(
      {required List<AnimeFilter> filtres,
      String? query,
      List<String>? tags}) async {
    var animeList = await repository.getAnimeList();
    animeList.sort((a, b) => b.animeSeason.year.compareTo(a.animeSeason.year));

    if (query != null && query.isNotEmpty) {
      animeList = animeList
          .where((anime) =>
              anime.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      print('useCase search list: ${animeList.length}');
    }

    if (filtres.isNotEmpty) {
      for (final filter in filtres) {
        animeList = filter(animeList);
        print('useCase filter list: ${animeList.length}');
      }
    }

    if (filtres.isEmpty && (query == null || query.isEmpty)) {
      return animeList;
    }

    return animeList;
  }
}
