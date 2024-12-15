import 'package:anime_app/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _user;

  String? get user => _user;

  void setUser(String user) {
    _user = user;
    notifyListeners();
  }
}
