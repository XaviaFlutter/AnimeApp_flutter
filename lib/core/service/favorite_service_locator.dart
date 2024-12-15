import 'package:anime_app/features/home/data/sources/favorite_local_data_source.dart';
import 'package:anime_app/features/home/data/repository/favorite_repository_impl.dart';
import 'package:anime_app/features/home/domain/repository/favorite_repository.dart';
import 'package:anime_app/features/home/domain/usecase/favorite_use_case.dart';
import 'package:anime_app/features/home/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupFavoriteDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton<FavoriteLocalDataSource>(
    () => FavoriteLocalDataSourceImpl(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<FavoriteRepository>(
    () =>
        FavoriteRepositoryImpl(localDataSource: sl<FavoriteLocalDataSource>()),
  );

  sl.registerLazySingleton<AddFavoriteUseCase>(
    () => AddFavoriteUseCase(repository: sl<FavoriteRepository>()),
  );
  sl.registerLazySingleton<RemoveFavoriteUseCase>(
    () => RemoveFavoriteUseCase(repository: sl<FavoriteRepository>()),
  );
  sl.registerLazySingleton<GetFavoritesUseCase>(
    () => GetFavoritesUseCase(repository: sl<FavoriteRepository>()),
  );

  sl.registerFactory(
    () => FavoriteCubit(
      addFavoriteUseCase: sl<AddFavoriteUseCase>(),
      removeFavoriteUseCase: sl<RemoveFavoriteUseCase>(),
      getFavoritesUseCase: sl<GetFavoritesUseCase>(),
    ),
  );
}
