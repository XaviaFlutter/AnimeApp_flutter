// To parse this JSON data, do
//
//     final registerDto = registerDtoFromJson(jsonString);

import 'dart:convert';

import 'package:anime_app/features/auth/domain/entity/auth_entity.dart';

LoginDto registerDtoFromJson(String str) => LoginDto.fromJson(json.decode(str));

String registerDtoToJson(LoginDto data) => json.encode(data.toJson());

class LoginDto {
  String password;
  String avatar;
  String name;

  LoginDto({
    required this.name,
    required this.password,
    this.avatar =
        'https://www.meme-arsenal.com/memes/a263824611ea565c5d6cc81186cf6113.jpg',
  });

  factory LoginDto.fromJson(Map<String, dynamic> json) => LoginDto(
        name: json["name"] ?? '',
        password: json["password"] ?? '',
        avatar: json["avatar"] ?? '',
      );

  Map<String, dynamic> toJson() => {"password": password, "name": name};

  AuthEntity toEntity() =>
      AuthEntity(avatar: avatar, password: '', name: name, email: '');
}
