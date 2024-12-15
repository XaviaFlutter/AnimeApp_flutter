// To parse this JSON data, do
//
//     final registerDto = registerDtoFromJson(jsonString);

import 'dart:convert';

import 'package:anime_app/features/auth/domain/entity/auth_entity.dart';

RegisterDto registerDtoFromJson(String str) =>
    RegisterDto.fromJson(json.decode(str));

String registerDtoToJson(RegisterDto data) => json.encode(data.toJson());

class RegisterDto {
  String email;
  String password;
  String avatar;
  String name;

  RegisterDto({
    required this.name,
    required this.email,
    required this.password,
    this.avatar =
        'https://www.meme-arsenal.com/memes/a263824611ea565c5d6cc81186cf6113.jpg',
  });

  factory RegisterDto.fromJson(Map<String, dynamic> json) => RegisterDto(
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        avatar: json["avatar"] ?? '',
      );

  Map<String, dynamic> toJson() =>
      {"email": email, "password": password, "avatar": avatar, "name": name};

  AuthEntity toEntity() =>
      AuthEntity(avatar: avatar, password: password, email: email, name: name);
}
