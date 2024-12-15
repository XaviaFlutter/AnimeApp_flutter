// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:anime_app/features/auth/presentation/screens/initial_screen.dart'
    as _i3;
import 'package:anime_app/features/auth/presentation/screens/sign_in_screen.dart'
    as _i4;
import 'package:anime_app/features/auth/presentation/screens/sign_up_screen.dart'
    as _i5;
import 'package:anime_app/features/home/presentation/screens/detail_screen.dart'
    as _i1;
import 'package:anime_app/features/home/presentation/screens/home_screen.dart'
    as _i2;
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

/// generated route for
/// [_i1.DetailScreen]
class DetailRoute extends _i6.PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    _i7.Key? key,
    required String title,
    required String imageUrl,
    required String index,
    required bool isFavorite,
    required String type,
    required String episode,
    required String status,
    required List<String> tags,
    required String season,
    required String year,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          DetailRoute.name,
          args: DetailRouteArgs(
            key: key,
            title: title,
            imageUrl: imageUrl,
            index: index,
            isFavorite: isFavorite,
            type: type,
            episode: episode,
            status: status,
            tags: tags,
            season: season,
            year: year,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailRouteArgs>();
      return _i1.DetailScreen(
        key: args.key,
        title: args.title,
        imageUrl: args.imageUrl,
        index: args.index,
        isFavorite: args.isFavorite,
        type: args.type,
        episode: args.episode,
        status: args.status,
        tags: args.tags,
        season: args.season,
        year: args.year,
      );
    },
  );
}

class DetailRouteArgs {
  const DetailRouteArgs({
    this.key,
    required this.title,
    required this.imageUrl,
    required this.index,
    required this.isFavorite,
    required this.type,
    required this.episode,
    required this.status,
    required this.tags,
    required this.season,
    required this.year,
  });

  final _i7.Key? key;

  final String title;

  final String imageUrl;

  final String index;

  final bool isFavorite;

  final String type;

  final String episode;

  final String status;

  final List<String> tags;

  final String season;

  final String year;

  @override
  String toString() {
    return 'DetailRouteArgs{key: $key, title: $title, imageUrl: $imageUrl, index: $index, isFavorite: $isFavorite, type: $type, episode: $episode, status: $status, tags: $tags, season: $season, year: $year}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.InitialScreen]
class InitialRoute extends _i6.PageRouteInfo<void> {
  const InitialRoute({List<_i6.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.InitialScreen();
    },
  );
}

/// generated route for
/// [_i4.SignInScreen]
class SignInRoute extends _i6.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SignInRouteArgs>(orElse: () => const SignInRouteArgs());
      return _i4.SignInScreen(key: args.key);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.SignUpScreen]
class SignUpRoute extends _i6.PageRouteInfo<void> {
  const SignUpRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return _i5.SignUpScreen();
    },
  );
}
