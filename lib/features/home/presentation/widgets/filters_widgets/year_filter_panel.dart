import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:anime_app/features/home/domain/usecase/anime_filter_usecase.dart';
import 'package:anime_app/features/home/presentation/bloc/anime_bloc/anime_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/provider/search_provider.dart';
import 'package:anime_app/features/home/presentation/widgets/filters_widgets/filter_button_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YearFilterPanel extends StatefulWidget {
  final VisibilityProvider provider;
  final double sliderValue;
  final Function(double) onSliderChanged;

  const YearFilterPanel({
    Key? key,
    required this.provider,
    required this.sliderValue,
    required this.onSliderChanged,
  }) : super(key: key);

  @override
  _YearFilterPanelState createState() => _YearFilterPanelState();
}

class _YearFilterPanelState extends State<YearFilterPanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          inactiveColor: context.backgroundColor,
          thumbColor: context.secondaryColor,
          activeColor: context.secondaryColor,
          min: widget.provider.minYear.toDouble(),
          max: widget.provider.maxYear.toDouble(),
          divisions: 200,
          value: widget.sliderValue.round().toDouble(),
          label: widget.sliderValue.round().toString(),
          onChanged: widget.onSliderChanged,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: widget.provider.isFilterYearActive,
              child: FilterButtonStyle.cancel(
                onTap: () {
                  widget.provider.setFilterYearActive(false);
                  widget.provider.updateSliderValue(2026);
                  context.read<AnimeBloc>().add(
                        AnimeFilterEvent(
                          query: widget.provider.query,
                          filters: [
                            widget.provider.isFilterStatusActive
                                ? filterByStatus(widget.provider.selectedStatus)
                                : resetYear(),
                            widget.provider.isFilsterTypesActive
                                ? filterByType(widget.provider.selectedTypes)
                                : resetYear(),
                            widget.provider.isFilterTagsActive
                                ? filterByTags(widget.provider.selectedTags)
                                : resetYear()
                          ],
                        ),
                      );
                },
                context: context,
              ),
            ),
            FilterButtonStyle.save(
              onTap: () {
                widget.provider.setFilterYearActive(true);
                context.read<AnimeBloc>().add(
                      AnimeFilterEvent(filters: [
                        widget.provider.isFilterStatusActive
                            ? filterByStatus(widget.provider.selectedStatus)
                            : resetYear(),
                        widget.provider.selectedTypes.isNotEmpty
                            ? filterByType(widget.provider.selectedTypes)
                            : resetYear(),
                        widget.provider.selectedTags.isEmpty
                            ? resetYear()
                            : filterByTags(widget.provider.selectedTags),
                        filterByYear(widget.sliderValue.round())
                      ], query: widget.provider.query),
                    );
              },
              context: context,
            ),
          ],
        )
      ],
    );
  }
}
