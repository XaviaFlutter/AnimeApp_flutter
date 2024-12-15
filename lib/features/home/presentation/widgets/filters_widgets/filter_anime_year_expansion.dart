import 'package:anime_app/core/style/app_margins.dart';
import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:anime_app/core/utils/media_query_extension.dart';
import 'package:anime_app/features/home/domain/usecase/anime_filter_usecase.dart';
import 'package:anime_app/features/home/presentation/bloc/anime_bloc/anime_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/provider/search_provider.dart';
import 'package:anime_app/features/home/presentation/widgets/filters_widgets/filter_button_style.dart';
import 'package:anime_app/features/home/presentation/widgets/filters_widgets/status_filter_panel.dart';
import 'package:anime_app/features/home/presentation/widgets/filters_widgets/year_filter_panel.dart';
import 'package:anime_app/features/home/presentation/widgets/filters_widgets/tags_filter_panel.dart';
import 'package:anime_app/features/home/presentation/widgets/filters_widgets/type_filter_panel.dart';
import 'package:anime_app/features/home/presentation/widgets/sliver_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class FilterYearAnimeExpansion extends StatefulWidget {
  final AnimeState animeState;

  const FilterYearAnimeExpansion({
    super.key,
    required this.animeState,
  });

  @override
  State<FilterYearAnimeExpansion> createState() =>
      _FilterYearAnimeExpansionState();
}

class _FilterYearAnimeExpansionState extends State<FilterYearAnimeExpansion> {
  double _valueSlider = 2026;

  @override
  void initState() {
    context.read<AnimeBloc>().add(GetStatusEvent());
    context.read<AnimeBloc>().add(GetTypesEvent());
    context.read<AnimeBloc>().add(GetTagsEvent());
    super.initState();

    final provider = Provider.of<VisibilityProvider>(context, listen: false);
    _valueSlider = provider.sliderValue;

    if (context.read<AnimeBloc>().state is! AnimeLoadedState) {
      context.read<AnimeBloc>().add(AnimeLoadEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisibilityProvider>(builder: (context, provider, _) {
      if (provider.panelList.isEmpty) {
        provider.initialPanel(4);
      }
      return SingleChildScrollView(
        child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) =>
                provider.setExpandedActive(index, isExpanded),
            children: List.generate(provider.panelList.length, (index) {
              if (index == 0) {
                return ExpansionPanel(
                    isExpanded: provider.panelList[index],
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(
                          provider.isFilterYearActive ? 'Годы *' : 'Годы',
                          style: TextStyle(color: context.primaryColor),
                        ),
                      );
                    },
                    body: YearFilterPanel(
                        provider: provider,
                        sliderValue: provider.sliderValue,
                        onSliderChanged: (double value) {
                          _valueSlider = (value / 5).round() * 5;
                          provider.updateSliderValue(value);
                        }));
              }
              if (index == 1) {
                return ExpansionPanel(
                    isExpanded: provider.panelList[index],
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(
                          !provider.isFilterTagsActive ? 'Тэги' : 'Тэги *',
                          style: TextStyle(
                            color: context.primaryColor,
                          ),
                        ),
                      );
                    },
                    body: TagsFilterPanel(valueSlider: _valueSlider));
              }
              if (index == 2) {
                return ExpansionPanel(
                    isExpanded: provider.panelList[index],
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(
                          provider.isFilsterTypesActive ? 'Тип *' : 'Тип',
                          style: TextStyle(color: context.primaryColor),
                        ),
                      );
                    },
                    body: TypeFilterPanel(valueSlider: _valueSlider));
              }
              if (index == 3) {
                return ExpansionPanel(
                    isExpanded: provider.panelList[index],
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(
                          'Статус',
                          style: TextStyle(color: context.primaryColor),
                        ),
                      );
                    },
                    body: const StatusFilterPanel());
              }
              return ExpansionPanel(
                  isExpanded: provider.panelList[index],
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return const ListTile();
                  },
                  body: const Column(
                    children: [],
                  ));
            })),
      );
    });
  }
}
