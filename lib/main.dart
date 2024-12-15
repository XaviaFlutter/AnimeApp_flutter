import 'dart:io';

import 'package:anime_app/core/routes/app_router.dart';
import 'package:anime_app/core/service/service_locator.dart';
import 'package:anime_app/core/style/app_theme.dart';
import 'package:anime_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:anime_app/features/auth/presentation/bloc/user_provider.dart';
import 'package:anime_app/features/home/presentation/bloc/anime_bloc/anime_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/provider/search_provider.dart';
import 'package:anime_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final _rootRouter = AppRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<FavoriteCubit>()..fetchFavorites(),
        ),
        BlocProvider(
          create: (_) => sl<AnimeBloc>()..add(AnimeLoadEvent()),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => VisibilityProvider())
      ],
      child: MaterialApp.router(
        routerConfig: _rootRouter.config(),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
