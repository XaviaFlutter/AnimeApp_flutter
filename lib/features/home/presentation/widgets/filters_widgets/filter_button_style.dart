import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:anime_app/features/home/presentation/bloc/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterButtonStyle {
  final VoidCallback onTap;

  FilterButtonStyle({
    required this.onTap,
  });

  static Widget cancel({required BuildContext context, VoidCallback? onTap}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(context.backgroundColor),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))),
        ),
      ),
      onPressed: onTap,
      child: const Text('Сбросить'),
    );
  }

  static Widget save({required BuildContext context, VoidCallback? onTap}) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(context.backgroundColor),
        backgroundColor: WidgetStatePropertyAll(context.primaryColor),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))),
        ),
      ),
      onPressed: onTap,
      child: const Text('Применить'),
    );
  }
}
