import 'dart:convert';

import 'package:anime_app/core/routes/app_router.gr.dart';
import 'package:anime_app/core/style/app_margins.dart';
import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:anime_app/features/home/presentation/bloc/anime_bloc/anime_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/provider/search_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final AnimeBloc animeBloc;
  SearchList({
    super.key,
    required this.visibilityProvider,
    required this.animeBloc,
  }) {
    _scrollController.addListener(_onScroll);
  }
  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      animeBloc.add(AnimeLoadNextPageEvent());
    }
  }

  final VisibilityProvider visibilityProvider;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeBloc, AnimeState>(
      builder: (context, state) {
        if (state is AnimeLoadedState) {
          return Visibility(
              visible: visibilityProvider.isSearchActive,
              child: SizedBox(
                height: 700,
                width: double.infinity,
                child: state.animeList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(AppSpacer.large),
                        child: GridView.builder(
                            controller: _scrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2),
                            itemCount: state.animeList.length + 1,
                            itemBuilder: (context, int index) {
                              if (index >= state.animeList.length) {
                                return state.hasReachedMax
                                    ? SizedBox.shrink()
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      );
                              }
                              return GestureDetector(
                                onTap: () {
                                  context.pushRoute(DetailRoute(
                                      year: state
                                          .animeList[index].animeSeason.year
                                          .toString(),
                                      season: state
                                          .animeList[index].animeSeason.season,
                                      tags: state.animeList[index].tags,
                                      status: state.animeList[index].status,
                                      type: state.animeList[index].type,
                                      episode: state.animeList[index].episodes
                                          .toString(),
                                      title: state.animeList[index].title,
                                      imageUrl: state.animeList[index].picture,
                                      index: state.animeList[index].title,
                                      isFavorite: false));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                                child: Icon(Icons.error),
                                              ),
                                          imageUrl: index <
                                                  state.animeList.length
                                              ? state.animeList[index].picture
                                              : ''),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        overflow: TextOverflow.clip,
                                        state.animeList[index].title,
                                        style: TextStyle(
                                            color: context.primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    : Center(
                        child: Text(
                          'Не найдено',
                          style: TextStyle(color: context.primaryColor),
                        ),
                      ),
              ));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
