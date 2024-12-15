import 'dart:convert';

import 'package:anime_app/features/home/domain/entity/anime_entity.dart';

AnimeDto animeDtoFromJson(String str) => AnimeDto.fromJson(json.decode(str));

class AnimeDto {
  License license;
  String repository;
  DateTime lastUpdate;
  List<Datum> data;

  AnimeDto({
    required this.license,
    required this.repository,
    required this.lastUpdate,
    required this.data,
  });

  factory AnimeDto.fromJson(Map<String, dynamic> json) => AnimeDto(
        license: License.fromJson(json["license"]),
        repository: json["repository"],
        lastUpdate: DateTime.parse(json["lastUpdate"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  List<String> sources;
  String title;
  String type;
  int episodes;
  String status;
  AnimeSeason animeSeason;
  String picture;
  String thumbnail;
  Duration duration;
  List<String> synonyms;
  List<String> relatedAnime;
  List<String> tags;

  Datum({
    required this.sources,
    required this.title,
    required this.type,
    required this.episodes,
    required this.status,
    required this.animeSeason,
    required this.picture,
    required this.thumbnail,
    required this.duration,
    required this.synonyms,
    required this.relatedAnime,
    required this.tags,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        sources: List<String>.from(json["sources"] ?? []),
        title: json["title"] ?? 'Unknown Title',
        type: json["type"] ?? 'Unknown Type',
        episodes: json["episodes"] ?? 0,
        status: json["status"] ?? 'Unknown Status',
        animeSeason: AnimeSeason.fromJson(json["animeSeason"] ?? {}),
        picture: json["picture"] ?? '',
        thumbnail: json["thumbnail"] ?? '',
        duration: Duration.fromJson(
            json["duration"] ?? {"value": 0, "unit": "minutes"}),
        synonyms: List<String>.from(json["synonyms"] ?? []),
        relatedAnime: List<String>.from(json["relatedAnime"] ?? []),
        tags: List<String>.from(json["tags"] ?? []),
      );

  // factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  //       sources: List<String>.from(json["sources"].map((x) => x)),
  //       title: json["title"],
  //       type: json["type"],
  //       episodes: json["episodes"],
  //       status: json["status"],
  //       animeSeason: AnimeSeason.fromJson(json["animeSeason"]),
  //       picture: json["picture"],
  //       thumbnail: json["thumbnail"],
  //       duration: Duration.fromJson(json["duration"]),
  //       synonyms: List<String>.from(json["synonyms"].map((x) => x)),
  //       relatedAnime: List<String>.from(json["relatedAnime"].map((x) => x)),
  //       tags: List<String>.from(json["tags"].map((x) => x)),
  //     );

  AnimeEntity toEntity() => AnimeEntity(
        duration: duration.toEntity(),
        picture: picture,
        title: title,
        type: type,
        episodes: episodes,
        status: status,
        animeSeason: animeSeason.toEntity(),
        tags: tags,
      );
}

class AnimeSeason {
  String season;
  int year;

  AnimeSeason({
    required this.season,
    required this.year,
  });

  factory AnimeSeason.fromJson(Map<String, dynamic> json) => AnimeSeason(
        season: json["season"] ?? 'Unknown Season',
        year: json["year"] ?? 0,
      );

  // factory AnimeSeason.fromJson(Map<String, dynamic> json) => AnimeSeason(
  //       season: json["season"],
  //       year: json["year"],
  //     );

  AnimeSeasonEntity toEntity() => AnimeSeasonEntity(
        season: season,
        year: year,
      );
}

class Duration {
  int value;
  String unit;

  Duration({
    required this.value,
    required this.unit,
  });

  factory Duration.fromJson(Map<String, dynamic> json) => Duration(
        value: json["value"] ?? 0, // Значение по умолчанию для value
        unit: json["unit"] ?? 'minutes',
      );
  // factory Duration.fromJson(Map<String, dynamic> json) => Duration(
  //       value: json["value"],
  //       unit: json["unit"],
  //     );

  DurationEntity toEntity() => DurationEntity(
        value: value,
        unit: unit,
      );
}

class License {
  String name;
  String url;

  License({
    required this.name,
    required this.url,
  });

  factory License.fromJson(Map<String, dynamic> json) => License(
        name: json["name"],
        url: json["url"],
      );
}
