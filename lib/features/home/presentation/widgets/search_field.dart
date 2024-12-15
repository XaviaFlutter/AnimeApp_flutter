import 'dart:ui';

import 'package:anime_app/core/style/app_margins.dart';
import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:anime_app/core/utils/media_query_extension.dart';
import 'package:anime_app/features/home/domain/usecase/anime_filter_usecase.dart';
import 'package:anime_app/features/home/presentation/bloc/anime_bloc/anime_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/provider/search_provider.dart';
import 'package:anime_app/features/home/presentation/widgets/filters_widgets/filter_anime_year_expansion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required TextEditingController textEditingController,
    required this.visibilityProvider,
    required FocusNode focusNode,
  })  : _textEditingController = textEditingController,
        _focusNode = focusNode;

  final TextEditingController _textEditingController;
  final VisibilityProvider visibilityProvider;
  final FocusNode _focusNode;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeBloc, AnimeState>(
      builder: (context, state) {
        return Consumer<VisibilityProvider>(
          builder: (context, provider, _) => TextField(
            controller: widget._textEditingController,
            decoration: InputDecoration(
                fillColor: context.surfaceColor,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: context.surfaceColor, width: 0),
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: context.surfaceColor, width: 0),
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                prefixIcon: Icon(
                  Icons.search,
                  color: context.primaryColor,
                ),
                suffixIcon: widget.visibilityProvider.isSearchActive
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              AppSpacer.medium),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 700,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: context.backgroundColor
                                                      .withOpacity(0)),
                                              width: double.infinity,
                                              height:
                                                  context.screenHeight * 0.5,
                                              child: FilterYearAnimeExpansion(
                                                animeState: state,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.sort,
                                color: context.primaryColor,
                              )),
                          IconButton(
                              onPressed: () {
                                widget._textEditingController.clear();
                                widget._focusNode.unfocus();
                                widget.visibilityProvider
                                    .setSearchActive(false);
                              },
                              icon: const Icon(Icons.close)),
                        ],
                      )
                    : null,
                suffixIconColor: context.primaryColor),
            style: TextStyle(color: context.primaryColor),
            focusNode: widget._focusNode,
            onChanged: (query) {
              final List<AnimeFilter> filters =
                  widget.visibilityProvider.isFilterYearActive
                      ? [filterByYear(provider.sliderValue.toInt().round())]
                      : [];
              widget.visibilityProvider.updateQuery(query);
              context
                  .read<AnimeBloc>()
                  .add(AnimeFilterEvent(filters: filters, query: query));
            },
          ),
        );
      },
    );
  }
}
