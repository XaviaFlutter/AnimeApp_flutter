import 'package:anime_app/features/home/domain/usecase/anime_filter_usecase.dart';
import 'package:anime_app/features/home/presentation/bloc/anime_bloc/anime_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/provider/search_provider.dart';
import 'package:anime_app/features/home/presentation/widgets/filters_widgets/filter_button_style.dart';
import 'package:anime_app/features/home/presentation/widgets/sliver_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TagsFilterPanel extends StatelessWidget {
  const TagsFilterPanel({
    super.key,
    required double valueSlider,
  }) : _valueSlider = valueSlider;

  final double _valueSlider;

  @override
  Widget build(BuildContext context) {
    return Consumer<VisibilityProvider>(
      builder: (context, provider, _) => Column(
        children: [
          BlocBuilder<AnimeBloc, AnimeState>(builder: (context, state) {
            if (state is AnimeLoadedState) {
              return SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: SliverTags(
                      isSearchTheme: true,
                      tags: state.tags.take(100).toList()));
            }
            if (state is AnimeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: provider.isFilterTagsActive,
                child: FilterButtonStyle.cancel(
                    onTap: () {
                      provider.setFilterTagsActive(false);
                      provider.clearTags();
                      provider.updateSliderValue(_valueSlider);
                      context.read<AnimeBloc>().add(
                              AnimeFilterEvent(query: provider.query, filters: [
                            provider.isFilterStatusActive
                                ? filterByStatus(provider.selectedStatus)
                                : resetYear(),
                            provider.isFilsterTypesActive
                                ? filterByType(provider.selectedTypes)
                                : resetYear(),
                            provider.isFilterYearActive
                                ? filterByYear(_valueSlider.toInt().round())
                                : resetYear(),
                          ]));
                    },
                    context: context),
              ),
              FilterButtonStyle.save(
                  onTap: () {
                    provider.selectedTags.isEmpty
                        ? null
                        : provider.setFilterTagsActive(true);
                    context.read<AnimeBloc>().add(AnimeFilterEvent(filters: [
                          provider.isFilterStatusActive
                              ? filterByStatus(provider.selectedStatus)
                              : resetYear(),
                          provider.isFilsterTypesActive
                              ? filterByType(provider.selectedTypes)
                              : resetYear(),
                          provider.isFilterYearActive
                              ? filterByYear(_valueSlider.toInt().round())
                              : resetYear(),
                          filterByTags(provider.selectedTags)
                        ]));
                  },
                  context: context),
            ],
          ),
        ],
      ),
    );
  }
}
