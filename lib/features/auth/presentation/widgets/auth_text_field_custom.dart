import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:flutter/material.dart';

class AuthTextFieldCustom {
  final TextEditingController controller;

  AuthTextFieldCustom({required this.controller});

  // Метод для создания InputDecoration с контекстом
  static InputDecoration _defaultDecoration(BuildContext context) {
    return InputDecoration(
      fillColor: context.surfaceColor,
      filled: true,
      hintStyle: TextStyle(
        color: context.primaryColor,
      ),
      border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.zero),
          borderSide: BorderSide(width: 3, color: context.primaryColor)),
      focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.zero),
          borderSide: BorderSide(width: 3, color: context.primaryColor)),
      enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.zero),
          borderSide: BorderSide(width: 3, color: context.primaryColor)),
    );
  }

  // Методы для создания виджетов с использованием контекста
  static Widget name({
    required BuildContext context,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      decoration: _defaultDecoration(context).copyWith(hintText: 'Никнейм'),
    );
  }

  static Widget email({
    required BuildContext context,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      decoration: _defaultDecoration(context).copyWith(hintText: 'Почта'),
    );
  }

  static Widget password({
    required BuildContext context,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      decoration: _defaultDecoration(context).copyWith(hintText: 'Пароль'),
    );
  }

  static Widget login({
    required BuildContext context,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      decoration: _defaultDecoration(context)
          .copyWith(hintText: 'Введите никнейм либо почту'),
    );
  }
}
