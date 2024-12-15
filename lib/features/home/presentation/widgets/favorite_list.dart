import 'package:anime_app/core/routes/app_router.dart';
import 'package:anime_app/core/routes/app_router.gr.dart';
import 'package:anime_app/core/style/app_margins.dart';
import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:anime_app/features/home/data/dto/anime_dto.dart';
import 'package:anime_app/features/home/domain/entity/anime_entity.dart';
import 'package:anime_app/features/home/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/provider/search_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({
    super.key,
    required this.visibilityProvider,
    required this.state,
  });

  final VisibilityProvider visibilityProvider;
  final FavoriteLoadedState state;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !visibilityProvider.isSearchActive,
      child: SizedBox(
        width: double.infinity,
        height: 500,
        child: ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final favorite = state.favorites[index];
              return SizedBox(
                height: 120,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () => context.pushRoute(DetailRoute(
                      season: favorite.season,
                      year: favorite.year,
                      tags: favorite.tags,
                      type: favorite.type,
                      episode: favorite.episode,
                      status: favorite.status,
                      isFavorite: true,
                      title: favorite.title,
                      imageUrl: favorite.picture,
                      index: favorite.title)),
                  child: Card(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          height: double.infinity,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: favorite.picture,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: AppSpacer.medium),
                          child: SizedBox(
                            width: 200,
                            child: Text(
                              overflow: TextOverflow.clip,
                              favorite.title,
                              style: TextStyle(
                                  color: context.primaryColor, fontSize: 16),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<FavoriteCubit>()
                                  .removeFavorite(favorite.id);
                            },
                            icon: Icon(
                              color: context.primaryColor,
                              Icons.favorite,
                              size: 20,
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
