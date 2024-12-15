class AnimeEntity {
  final String title;
  final String type;
  final int episodes;
  final String status;
  final AnimeSeasonEntity animeSeason;
  final List<String> tags;
  final String picture;
  final DurationEntity duration;

  AnimeEntity({
    required this.duration,
    required this.picture,
    required this.title,
    required this.type,
    required this.episodes,
    required this.status,
    required this.animeSeason,
    required this.tags,
  });
}

class AnimeSeasonEntity {
  final String season;
  final int year;

  AnimeSeasonEntity({
    required this.season,
    required this.year,
  });
}

class DurationEntity {
  final int value;
  final String unit;

  DurationEntity({required this.value, required this.unit});
}
