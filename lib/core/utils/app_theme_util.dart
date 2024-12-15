import 'package:flutter/material.dart';

extension ThemeColors on BuildContext {
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get backgroundColor => Theme.of(this).colorScheme.onSurface;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  Color get errorColor => Theme.of(this).colorScheme.error;
}
