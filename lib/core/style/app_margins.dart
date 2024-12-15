import 'package:flutter/material.dart';

class AppSpacer {
  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;
  static const double extraLarge = 32;

  // Метод для вертикального отступа
  static SizedBox vertical(double value) => SizedBox(height: value);

  // Метод для горизонтального отступа
  static SizedBox horizontal(double value) => SizedBox(width: value);

  // Упрощенные варианты
  static SizedBox smallVertical() => vertical(small);
  static SizedBox smallHorizontal() => horizontal(small);
  static SizedBox mediumVertical() => vertical(medium);
  static SizedBox mediumHorizontal() => horizontal(medium);
  static SizedBox largeVertical() => vertical(large);
  static SizedBox largeHorizontal() => horizontal(large);
  static SizedBox extraLargeVertical() => vertical(extraLarge);
  static SizedBox extraLargeHorizontal() => horizontal(extraLarge);
}
