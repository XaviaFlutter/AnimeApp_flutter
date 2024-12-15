import 'package:flutter/material.dart';

class VisibilityProvider extends ChangeNotifier {
  bool _isSearchActive = false;
  bool _isFilterYearActive = false;
  bool _isFilterTagsActive = false;
  bool _isFilsterTypesActive = false;
  bool _isFilterStatusActive = false;
  final bool _isExpanded = false;
  List<bool> _panelList = [];
  double sliderValue = 2024;
  int minYear = 1920;
  int maxYear = 2026;
  String _query = '';
  List<String> _selectegTags = [];
  List<String> _selectedTypes = [];
  List<String> _selectedStatus = [];

  String get query => _query;
  bool get isFilterStatusActive => _isFilterStatusActive;
  bool get isFilsterTypesActive => _isFilsterTypesActive;
  bool get isFilterTagsActive => _isFilterTagsActive;
  bool get isFilterYearActive => _isFilterYearActive;
  bool get isSearchActive => _isSearchActive;
  bool get isExpanded => _isExpanded;
  List<bool> get panelList => _panelList;
  List<String> get selectedTags => _selectegTags;
  List<String> get selectedTypes => _selectedTypes;
  List<String> get selectedStatus => _selectedStatus;

//---Тэги---
  void addTag(String tag) {
    if (_selectegTags.contains(tag)) {
      _selectegTags.remove(tag);
    } else {
      _selectegTags.add(tag);
    }
    notifyListeners();
  }

  void clearTags() {
    _selectegTags.clear();
    notifyListeners();
  }

  void setFilterTagsActive(bool value) {
    _isFilterTagsActive = value;
    notifyListeners();
  }

//---Типы---
  setFilterTypeActive(bool value) {
    _isFilsterTypesActive = value;
    notifyListeners();
  }

  void addType(String type) {
    if (_selectedTypes.contains(type)) {
      _selectedTypes.clear();
    } else {
      _selectedTypes = [type];
    }
    notifyListeners();
  }

  void clearTypes() {
    _selectedTypes.clear();
    notifyListeners();
  }

//---Года---
  void setFilterYearActive(bool value) {
    _isFilterYearActive = value;
    notifyListeners();
  }

  void updateSliderValue(double value) {
    sliderValue = ((value ~/ 5) * 5).toDouble();
    sliderValue = value;
    notifyListeners();
  }

  void updateQuery(String newQuery) {
    _query = newQuery;
    notifyListeners();
  }

//---Статус---
  setFilterStatusActive(bool value) {
    _isFilterStatusActive = value;
    notifyListeners();
  }

  void addStatus(String status) {
    if (_selectedStatus.contains(status)) {
      _selectedStatus.clear();
    } else {
      _selectedStatus = [status];
    }
    notifyListeners();
  }

  void clearStatus() {
    _selectedStatus.clear();
    notifyListeners();
  }

  //---Поиск---
  void setSearchActive(bool value) {
    _isSearchActive = value;
    notifyListeners();
  }

  void initialPanel(int count) {
    _panelList = List.generate(count, (_) => false);
  }

  void setExpandedActive(int index, bool isExpanded) {
    _panelList[index] = isExpanded;
    notifyListeners();
  }
}
