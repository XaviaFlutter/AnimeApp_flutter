import 'package:anime_app/core/models/menu_model.dart';
import 'package:anime_app/core/routes/app_router.dart';
import 'package:anime_app/core/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class MenuManager {
  List<MenuModel> getMenuItems(BuildContext context) {
    return [
      MenuModel(title: 'Избранное', icon: Icons.favorite, action: () {}),
      MenuModel(title: 'Поделится избранным', icon: Icons.share, action: () {}),
      MenuModel(title: 'Настройки', icon: Icons.settings, action: () {}),
      MenuModel(
          title: 'Выйти',
          icon: Icons.logout,
          action: () {
            context.pushRoute(SignUpRoute());
          })
    ];
  }
}
