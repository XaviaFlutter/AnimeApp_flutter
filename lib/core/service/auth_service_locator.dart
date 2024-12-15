import 'package:anime_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:anime_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:anime_app/features/auth/domain/repository/auth_repository.dart';
import 'package:anime_app/features/auth/domain/usecase/get_profile_use_case.dart';
import 'package:anime_app/features/auth/domain/usecase/login_user_use_case.dart';
import 'package:anime_app/features/auth/domain/usecase/register_user_use_case.dart';
import 'package:anime_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupAuthDependencies() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource('https://04d3-95-87-64-179.ngrok-free.app'));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl<AuthRemoteDataSource>()),
  );

  sl.registerLazySingleton(() => RegisterUserUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LoginUserUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(
      () => GetProfileUseCase(authRepository: sl<AuthRepository>()));
  sl.registerFactory(() => AuthBloc(sl<RegisterUserUseCase>(),
      sl<LoginUserUseCase>(), sl<GetProfileUseCase>()));
}
