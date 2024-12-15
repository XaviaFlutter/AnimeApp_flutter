import 'package:anime_app/features/home/domain/entity/anime_entity.dart';

typedef AnimeFilter = List<AnimeEntity> Function(List<AnimeEntity>);

AnimeFilter filterByYear(int year) {
  return (animeList) =>
      animeList.where((anime) => anime.animeSeason.year == year).toList();
}

AnimeFilter resetYear() {
  return (animeList) => animeList;
}

AnimeFilter filterByTags(List<String> tags) {
  if (tags != null && tags.isNotEmpty) {
    return (animeList) => animeList = animeList
        .where((anime) => tags.every((tag) => anime.tags.contains(tag)))
        .toList();
  } else {
    return (animeList) => animeList;
  }
}

AnimeFilter filterByType(List<String> types) {
  if (types != null && types.isNotEmpty) {
    return (animeList) => animeList = animeList
        .where((anime) => types.any((type) => anime.type.contains(type)))
        .toList();
  } else {
    return (animeList) => animeList;
  }
}

AnimeFilter filterByStatus(List<String> status) {
  if (status != null && status.isNotEmpty) {
    return (animeList) => animeList = animeList
        .where((anime) => status.any((status) => anime.status.contains(status)))
        .toList();
  } else {
    return (animeList) => animeList;
  }
}
