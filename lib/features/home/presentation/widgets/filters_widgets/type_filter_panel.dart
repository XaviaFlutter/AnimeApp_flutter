import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:anime_app/core/utils/media_query_extension.dart';
import 'package:anime_app/features/home/domain/usecase/anime_filter_usecase.dart';
import 'package:anime_app/features/home/presentation/bloc/anime_bloc/anime_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/provider/search_provider.dart';
import 'package:anime_app/features/home/presentation/widgets/filters_widgets/filter_button_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TypeFilterPanel extends StatelessWidget {
  const TypeFilterPanel({
    super.key,
    required double valueSlider,
  }) : _valueSlider = valueSlider;

  final double _valueSlider;

  @override
  Widget build(BuildContext context) {
    return Consumer<VisibilityProvider>(
      builder: (context, provider, _) =>
          BlocBuilder<AnimeBloc, AnimeState>(builder: (context, state) {
        if (state is AnimeLoadedState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                    width: context.screenHeight * 0.3,
                    height: context.screenHeight * 0.25,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                crossAxisCount: 3),
                        itemCount: state.types.length,
                        itemBuilder: (context, index) =>
                            Consumer<VisibilityProvider>(
                              builder: (context, provider, _) =>
                                  GestureDetector(
                                onTap: () {
                                  provider.addType(state.types[index]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: provider.selectedTypes
                                              .contains(state.types[index])
                                          ? context.secondaryColor
                                          : context.backgroundColor),
                                  width: 100,
                                  child: Center(
                                    child: FittedBox(
                                      child: Text(
                                        state.types[index],
                                        style: TextStyle(
                                            color: context.primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: provider.isFilsterTypesActive,
                    child: FilterButtonStyle.cancel(
                        onTap: () {
                          provider.setFilterTypeActive(false);
                          context
                              .read<AnimeBloc>()
                              .add(AnimeFilterEvent(filters: [
                                provider.isFilterStatusActive
                                    ? filterByStatus(provider.selectedStatus)
                                    : resetYear(),
                                provider.isFilterTagsActive
                                    ? filterByTags(provider.selectedTags)
                                    : filterByType([]),
                                provider.isFilterYearActive
                                    ? filterByYear(
                                        _valueSlider.toInt().round(),
                                      )
                                    : resetYear()
                              ]));
                          provider.clearTypes();
                        },
                        context: context),
                  ),
                  FilterButtonStyle.save(
                      onTap: () {
                        provider.setFilterTypeActive(true);
                        context
                            .read<AnimeBloc>()
                            .add(AnimeFilterEvent(filters: [
                              provider.isFilterStatusActive
                                  ? filterByStatus(provider.selectedStatus)
                                  : resetYear(),
                              filterByTags(provider.selectedTags),
                              provider.isFilterYearActive
                                  ? filterByYear(_valueSlider.toInt().round())
                                  : resetYear(),
                              filterByType(provider.selectedTypes.toList())
                            ]));
                      },
                      context: context),
                ],
              )
            ],
          );
        }
        if (state is AnimeLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox.shrink();
      }),
    );
  }
}
