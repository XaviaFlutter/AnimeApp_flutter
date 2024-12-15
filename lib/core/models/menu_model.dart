import 'package:flutter/material.dart';

class MenuModel {
  final String title;
  final IconData icon;
  final VoidCallback action;

  MenuModel({required this.title, required this.icon, required this.action});
}
