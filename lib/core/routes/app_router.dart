import 'package:auto_route/auto_route.dart';
import 'package:anime_app/core/routes/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
        ),
        AutoRoute(page: InitialRoute.page, initial: true),
        AutoRoute(page: DetailRoute.page),
        AutoRoute(
          page: SignUpRoute.page,
        ),
        AutoRoute(
          page: SignInRoute.page,
        )!
      ];
}
