import 'package:anime_app/features/home/data/dto/anime_dto.dart';
import 'package:anime_app/features/home/domain/entity/anime_entity.dart';

class FavoriteEntity {
  final String season;
  final String year;
  final String id;
  final String title;
  final String picture;
  final String type;
  final String episode;
  final String status;
  final List<String> tags;

  FavoriteEntity({
    required this.season,
    required this.year,
    required this.type,
    required this.episode,
    required this.status,
    required this.id,
    required this.title,
    required this.picture,
    required this.tags,
  });
}
