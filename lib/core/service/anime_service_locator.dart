// core/di/service_locator.dart
import 'package:anime_app/features/home/domain/usecase/get_anime_list_usecase.dart';
import 'package:anime_app/features/home/presentation/bloc/anime_bloc/anime_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:anime_app/features/home/data/repository/anime_repository_impl.dart';
import 'package:anime_app/features/home/data/sources/anime_local_data_source.dart';
import 'package:anime_app/features/home/domain/repository/anime_repository.dart';

final sl = GetIt.instance;

void setupAnimeDependencies() {
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSource());
  sl.registerLazySingleton<AnimeRepository>(
    () => AnimeRepositoryImpl(sl<LocalDataSource>()),
  );
  sl.registerLazySingleton<GetAnimeListUseCase>(
    () => GetAnimeListUseCase(sl<AnimeRepository>()),
  );

  sl.registerLazySingleton<FilterAnimeUseCase>(
      () => FilterAnimeUseCase(sl<AnimeRepository>()));

  sl.registerLazySingleton<GetAllTagsUseCase>(
      () => GetAllTagsUseCase(sl<AnimeRepository>()));

  sl.registerLazySingleton<GetAllTypesUseCase>(
      () => GetAllTypesUseCase(sl<AnimeRepository>()));

  sl.registerLazySingleton<GetAllStatusUseCase>(
      () => GetAllStatusUseCase(sl<AnimeRepository>()));

  sl.registerFactory(() => AnimeBloc(
        getAllStatusUseCase: sl<GetAllStatusUseCase>(),
        getAllTypesUseCase: sl<GetAllTypesUseCase>(),
        getAllTagsUseCase: sl<GetAllTagsUseCase>(),
        filterAnimeUseCase: sl<FilterAnimeUseCase>(),
        getAnimeListUseCase: sl<GetAnimeListUseCase>(),
      ));
}
