import 'dart:ui';

import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:anime_app/core/utils/media_query_extension.dart';
import 'package:anime_app/features/home/presentation/bloc/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliverTags extends StatelessWidget {
  const SliverTags({
    super.key,
    required this.tags,
    this.isSearchTheme = false,
  });

  final List<String> tags;
  final bool isSearchTheme;

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width - 30;
    const double heightTag = 30;
    const double marginTags = 4;
    double tagWidthCalculate(String tag) {
      final TextPainter textPainter = TextPainter(
          text: TextSpan(text: tag),
          maxLines: 1,
          textDirection: TextDirection.ltr)
        ..layout();
      return textPainter.width;
    }

    List<List<String>> _buildRows() {
      List<List<String>> rows = [];
      List<String> currentRow = [];
      double currentRowWidth = 0;

      for (var tag in tags) {
        final tagWidth = tagWidthCalculate(tag) + marginTags * 2;
        if (currentRowWidth + tagWidth > widthScreen) {
          rows.add(currentRow);
          currentRow = [];
          currentRowWidth = 0;
        }
        currentRow.add(tag);
        currentRowWidth += tagWidth;
      }
      if (currentRow.isNotEmpty) rows.add(currentRow);
      return rows;
    }

    final rows = _buildRows();

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final rowTags = rows[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: rowTags.map((tag) {
                return Consumer<VisibilityProvider>(
                  builder: (context, provider, _) => GestureDetector(
                    onTap: () {
                      provider.addTag(tag);
                    },
                    child: Container(
                      height: heightTag,
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: isSearchTheme
                              ? provider.selectedTags.contains(tag)
                                  ? context.secondaryColor
                                  : context.backgroundColor
                              : context.surfaceColor,
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          tag,
                          style: TextStyle(
                              color: context.primaryColor, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }, childCount: rows.length),
        ),
      ],
    );
  }
}
