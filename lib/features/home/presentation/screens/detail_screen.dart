import 'dart:ui';

import 'package:anime_app/core/style/app_margins.dart';
import 'package:anime_app/core/utils/media_query_extension.dart';
import 'package:anime_app/features/home/data/dto/anime_dto.dart';
import 'package:anime_app/features/home/domain/entity/anime_entity.dart';
import 'package:anime_app/features/home/domain/entity/favorite_entity.dart';
import 'package:anime_app/features/home/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:anime_app/features/home/presentation/widgets/preview_anime_detail.dart';
import 'package:anime_app/features/home/presentation/widgets/sliver_tags.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mosaic/flutter_mosaic.dart';
import 'package:provider/provider.dart';

@RoutePage()
class DetailScreen extends StatelessWidget {
  const DetailScreen(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.index,
      required this.isFavorite,
      required this.type,
      required this.episode,
      required this.status,
      required this.tags,
      required this.season,
      required this.year});
  final String season;
  final String year;
  final List<String> tags;
  final String title;
  final String imageUrl;
  final String index;
  final String type;
  final String episode;
  final String status;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    String isZero = episode == '0' ? '' : episode;
    double fontSize = title.length > 20 ? 20 : 28;
    print(status);
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 300,
          child: PreviewAnimeDetail(
              imageUrl: imageUrl, type: type, status: status, isZero: isZero),
        ),
        Text(
          maxLines: 2,
          title,
          style: TextStyle(color: context.primaryColor, fontSize: fontSize),
        ),
        BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            print(state);
            final favoriteCubit = context.read<FavoriteCubit>();
            final isFavorite = favoriteCubit.isFavorite(index.toString());
            if (state is FavoriteLoadedState) {
              return IconButton(
                  onPressed: () {
                    final favoriteCubit =
                        BlocProvider.of<FavoriteCubit>(context);
                    final favoriteEntity = FavoriteEntity(
                        year: year.toString(),
                        season: season,
                        tags: tags,
                        status: status.toString(),
                        type: type.toString(),
                        episode: episode.toString(),
                        id: index.toString(),
                        title: title,
                        picture: imageUrl);
                    if (isFavorite) {
                      favoriteCubit.removeFavorite(index.toString());
                    } else {
                      favoriteCubit.addFavorite(favoriteEntity);
                    }
                    print('detailScreen: $index');
                  },
                  icon: isFavorite
                      ? Icon(
                          Icons.favorite,
                          color: context.primaryColor,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: context.primaryColor,
                        ));
            } else {
              return SizedBox.shrink();
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacer.large),
          child: SizedBox(
              width: double.infinity,
              height: context.screenHeight * 0.2,
              child: SliverTags(
                tags: tags,
              )),
        ),
        RichText(
            text: TextSpan(
                style: TextStyle(color: context.primaryColor, fontSize: 16),
                children: [
              TextSpan(text: 'Release Date - ', style: TextStyle(fontSize: 14)),
              TextSpan(
                  text: '$season',
                  style: TextStyle(color: context.surfaceColor)),
              TextSpan(text: ' $year')
            ]))
      ]),
    );
  }
}
