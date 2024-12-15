// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'package:anime_app/features/home/data/dto/anime_dto.dart';
import 'package:anime_app/features/home/domain/entity/favorite_entity.dart';

class FavoriteModel extends FavoriteEntity {
  FavoriteModel(
      {required super.year,
      required super.season,
      required super.id,
      required super.title,
      required super.picture,
      required super.type,
      required super.episode,
      required super.status,
      required super.tags});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    print(json);
    print(json["year"]);
    return FavoriteModel(
      year: json["year"] ?? '',
      season: json["season"] ?? '',
      tags: (json["tags"] as List<dynamic>? ?? [])
          .map((tag) => tag.toString())
          .toList(),
      id: json["id"] ?? '',
      title: json["title"] ?? '',
      picture: json["picture"] ?? '',
      type: json["type"] ?? '',
      episode: json["episode"] ?? '',
      status: json["status"] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        "year": year,
        "season": season,
        "tags": tags,
        "id": id,
        "title": title,
        "picture": picture,
        "type": type,
        "episode": episode,
        "status": status
      };
}
