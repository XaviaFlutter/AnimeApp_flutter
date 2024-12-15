import 'package:anime_app/features/home/domain/entity/anime_entity.dart';

abstract class AnimeRepository {
  Future<List<AnimeEntity>> getAnimeList();
}
