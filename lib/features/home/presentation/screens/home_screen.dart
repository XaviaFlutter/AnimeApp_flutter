import 'package:anime_app/core/managers/menu_manager.dart';
import 'package:anime_app/core/models/menu_model.dart';
import 'package:anime_app/core/routes/app_router.gr.dart';
import 'package:anime_app/core/style/app_margins.dart';
import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:anime_app/core/utils/media_query_extension.dart';
import 'package:anime_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:anime_app/features/auth/presentation/bloc/user_provider.dart';
import 'package:anime_app/features/home/presentation/bloc/anime_bloc/anime_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/provider/search_provider.dart';
import 'package:anime_app/features/home/presentation/widgets/favorite_list.dart';
import 'package:anime_app/features/home/presentation/widgets/search_field.dart';
import 'package:anime_app/features/home/presentation/widgets/search_list.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;
  final bool isExpanded;
  late List<MenuModel> menuItems;

  _HomeScreenState({this.isExpanded = false});

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final currentUser = userProvider.user;
    context
        .read<AuthBloc>()
        .add(GetUserProfileEvent(username: currentUser.toString()));
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    menuItems = MenuManager().getMenuItems(context);
    _focusNode.addListener(() {
      final visibilityProvider =
          Provider.of<VisibilityProvider>(context, listen: false);
      if (_focusNode.hasFocus) {
        visibilityProvider.setSearchActive(true);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibilityProvider = Provider.of<VisibilityProvider>(context);
    return Scaffold(
      drawer: Drawer(
        backgroundColor: context.surfaceColor.withValues(alpha: 0.85),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: context.secondaryColor),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is ProfileLoaded) {
                      return SizedBox.expand(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageBuilder: (context, image) => Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: image, fit: BoxFit.cover)),
                              ),
                              imageUrl: state.profile.avatar,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(
                              width: AppSpacer.medium,
                            ),
                            Text(
                              state.profile.name,
                              style: TextStyle(
                                  color: context.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: AppSpacer.medium,
                            ),
                            FittedBox(
                              child: Text(
                                state.profile.email,
                                style: TextStyle(
                                  color: context.primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (state is AuthFailure) {
                      return Text('${state.message}');
                    } else {
                      return Container();
                    }
                  },
                )),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: context.screenHeight * 0.4,
              child: ListView.builder(
                  itemCount: MenuManager().getMenuItems(context).length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.5, color: context.backgroundColor))),
                      child: GestureDetector(
                        onTap: item.action,
                        child: ListTile(
                          leading: Icon(item.icon),
                          tileColor: context.primaryColor,
                          title: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const Spacer(),
            ElevatedButton(onPressed: () {}, child: const Text('О нас'))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: AppSpacer.large,
            left: AppSpacer.large,
            right: AppSpacer.large),
        child: Column(
          children: [
            BlocBuilder<AnimeBloc, AnimeState>(
              builder: (context, state) {
                if (state is AnimeLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AnimeLoadedState) {
                  return Consumer<VisibilityProvider>(
                    builder: (context, provider, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: !provider.isSearchActive
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: !provider.isSearchActive,
                                child: IconButton(
                                    onPressed: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                    icon: Icon(
                                      Icons.menu,
                                      color: context.primaryColor,
                                    )),
                              ),
                              SizedBox(
                                width: visibilityProvider.isSearchActive
                                    ? 300
                                    : 150,
                                child: SearchField(
                                    textEditingController:
                                        _textEditingController,
                                    visibilityProvider: visibilityProvider,
                                    focusNode: _focusNode),
                              ),
                            ],
                          ),
                          SearchList(
                            animeBloc: context.read<AnimeBloc>(),
                            visibilityProvider: visibilityProvider,
                          ),
                          Visibility(
                            visible: !visibilityProvider.isSearchActive,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Latest',
                                  style: TextStyle(color: context.primaryColor),
                                ),
                                SizedBox(
                                  height: 220,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      width: 20,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.animeLatest.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.pushRoute(DetailRoute(
                                                  year: state.animeLatest[index]
                                                      .animeSeason.year
                                                      .toString(),
                                                  season: state
                                                      .animeLatest[index]
                                                      .animeSeason
                                                      .season,
                                                  tags: state
                                                      .animeLatest[index].tags,
                                                  type: state
                                                      .animeLatest[index].type,
                                                  episode: state
                                                      .animeLatest[index]
                                                      .episodes
                                                      .toString(),
                                                  status: state
                                                      .animeLatest[index]
                                                      .status,
                                                  isFavorite: false,
                                                  index: state
                                                      .animeLatest[index].title,
                                                  title: state
                                                      .animeLatest[index].title
                                                      .toString(),
                                                  imageUrl: state
                                                      .animeLatest[index]
                                                      .picture
                                                      .toString()));
                                            },
                                            child: SizedBox(
                                              width: 100,
                                              height: 150,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(7)),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: state
                                                      .animeLatest[index]
                                                      .picture
                                                      .toString(),
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              state.animeLatest[index].title,
                                              style: TextStyle(
                                                  color: context.primaryColor,
                                                  fontSize: 12),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  );
                } else if (state is AnimeFailureState) {
                  return Center(child: Text("Error: ${state.message}"));
                }
                return const SizedBox.shrink();
              },
            ),
            BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
              if (state is FavoriteLodaingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FavoriteLoadedState) {
                return FavoriteList(
                  visibilityProvider: visibilityProvider,
                  state: state,
                );
              } else if (state is FavoriteErrorState) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
