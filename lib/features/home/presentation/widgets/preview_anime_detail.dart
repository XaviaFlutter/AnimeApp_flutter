import 'dart:ui';

import 'package:anime_app/core/style/app_margins.dart';
import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mosaic/flutter_mosaic.dart';

class PreviewAnimeDetail extends StatelessWidget {
  const PreviewAnimeDetail({
    super.key,
    required this.imageUrl,
    required this.type,
    required this.status,
    required this.isZero,
  });

  final String imageUrl;
  final String type;
  final String status;
  final String isZero;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration:
              BoxDecoration(color: context.backgroundColor.withOpacity(1)),
          height: 300,
          width: double.infinity,
          child: Mosaic(
            mosaicSize: const Size(5, 5),
            child: ImageFiltered(
              imageFilter: ColorFilter.mode(
                  context.backgroundColor, BlendMode.saturation),
              child: ImageFiltered(
                imageFilter: ColorFilter.mode(
                    context.backgroundColor.withOpacity(0.8), BlendMode.darken),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacer.extraLarge),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateX(-0.2)
                ..rotateY(0.6),
              child: Transform.rotate(
                angle: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: context.surfaceColor,
                      ),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: -7,
                            blurRadius: 20,
                            color: context.surfaceColor)
                      ],
                      color: context.backgroundColor.withOpacity(1)),
                  height: 200,
                  width: 150,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: AppSpacer.extraLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  type,
                  style: TextStyle(
                      color: context.surfaceColor,
                      fontSize: 24,
                      letterSpacing: 2),
                ),
                Text(
                  status,
                  style: TextStyle(
                      color: context.primaryColor,
                      fontSize: 24,
                      letterSpacing: 2),
                ),
                Text(
                  isZero,
                  style: TextStyle(
                      color: context.surfaceColor,
                      fontSize: 24,
                      letterSpacing: 2),
                ),
              ],
            ),
          ),
        ),
        IconButton(
            style: ButtonStyle(
                iconColor: WidgetStatePropertyAll(context.primaryColor),
                backgroundColor: WidgetStatePropertyAll(context.surfaceColor),
                shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero)))),
            onPressed: () {
              context.maybePop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ],
    );
  }
}
