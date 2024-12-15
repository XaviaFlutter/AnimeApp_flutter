import 'package:anime_app/core/service/anime_service_locator.dart';
import 'package:anime_app/core/service/auth_service_locator.dart';
import 'package:anime_app/core/service/favorite_service_locator.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupDependencies() {
  setupAuthDependencies();
  setupAnimeDependencies();
  setupFavoriteDependencies();
}
