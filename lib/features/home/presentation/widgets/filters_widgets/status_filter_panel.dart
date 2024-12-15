import 'package:anime_app/core/style/app_margins.dart';
import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:anime_app/core/utils/media_query_extension.dart';
import 'package:anime_app/features/home/domain/usecase/anime_filter_usecase.dart';
import 'package:anime_app/features/home/presentation/bloc/anime_bloc/anime_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/provider/search_provider.dart';
import 'package:anime_app/features/home/presentation/widgets/filters_widgets/filter_button_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class StatusFilterPanel extends StatelessWidget {
  const StatusFilterPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<VisibilityProvider>(
      builder: (context, provider, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacer.large),
            child: SizedBox(
              height: context.screenHeight * 0.1,
              width: double.infinity,
              child:
                  BlocBuilder<AnimeBloc, AnimeState>(builder: (context, state) {
                if (state is AnimeLoadedState) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: AppSpacer.small,
                    ),
                    itemCount: state.status.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        provider.addStatus(state.status[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: provider.selectedStatus
                                    .contains(state.status[index])
                                ? context.secondaryColor
                                : context.backgroundColor),
                        width: context.screenWidth * 0.18,
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              state.status[index],
                              style: TextStyle(color: context.primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                if (state is AnimeLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SizedBox.shrink();
              }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: provider.isFilterStatusActive,
                child: FilterButtonStyle.cancel(
                    onTap: () {
                      provider.setFilterStatusActive(false);
                      provider.clearStatus();
                      context.read<AnimeBloc>().add(AnimeFilterEvent(filters: [
                            filterByStatus(provider.selectedStatus),
                            provider.isFilsterTypesActive
                                ? filterByType(provider.selectedTypes)
                                : resetYear(),
                            provider.isFilterTagsActive
                                ? filterByTags(provider.selectedTags)
                                : resetYear(),
                            provider.isFilterYearActive
                                ? filterByYear(provider.sliderValue.toInt())
                                : resetYear()
                          ]));
                    },
                    context: context),
              ),
              FilterButtonStyle.save(
                  onTap: () {
                    provider.setFilterStatusActive(true);
                    context.read<AnimeBloc>().add(AnimeFilterEvent(filters: [
                          provider.isFilsterTypesActive
                              ? filterByType(provider.selectedTypes)
                              : resetYear(),
                          provider.isFilterTagsActive
                              ? filterByTags(provider.selectedTags)
                              : resetYear(),
                          provider.isFilterYearActive
                              ? filterByYear(provider.sliderValue.toInt())
                              : resetYear(),
                          filterByStatus(provider.selectedStatus)
                        ]));
                  },
                  context: context)
            ],
          ),
        ],
      ),
    );
  }
}
