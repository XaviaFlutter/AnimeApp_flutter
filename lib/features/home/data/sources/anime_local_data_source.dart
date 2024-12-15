import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:anime_app/features/home/data/dto/anime_dto.dart';

class LocalDataSource {
  Future<List<Datum>> loadAnimeData() async {
    final String jsonString =
        await rootBundle.loadString('assets/anime-offline-database.json');
    final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

    final List<dynamic> dataList = jsonResponse['data'];

    return dataList.map((item) => Datum.fromJson(item)).toList();
  }
}

// import 'dart:convert';
// import 'package:anime_app/features/home/data/dto/anime_dto.dart';
// import 'package:flutter/services.dart';

// class LocalDataSource {
//   Future<List<Datum>> loadAnimeData() async {
//     final String jsonString =
//         await rootBundle.loadString('assets/anime-offline-database.json');
//     final List<dynamic> jsonResponse = jsonDecode(jsonString);
//     return jsonResponse.map((item) => Datum.fromJson(item)).toList();
//   }
// }