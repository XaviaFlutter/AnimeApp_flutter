import 'package:anime_app/features/home/data/sources/anime_local_data_source.dart';
import 'package:anime_app/features/home/domain/entity/anime_entity.dart';
import 'package:anime_app/features/home/domain/repository/anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final LocalDataSource localDataSource;

  AnimeRepositoryImpl(this.localDataSource);

  Future<List<AnimeEntity>> getAnimeList() async {
    final dtoList = await localDataSource.loadAnimeData();
    return dtoList.map((dto) => dto.toEntity()).toList();
  }

  // Future<List<AnimeEntity>> getAnimeList() async {
  //   final dtoList = await localDataSource.loadAnimeData();
  //   return dtoList.map((dto) => dto.toEntity()).toList();
  // }
}
