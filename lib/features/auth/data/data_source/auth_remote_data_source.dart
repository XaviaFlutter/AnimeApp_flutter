import 'package:anime_app/features/auth/data/dto/login_dto.dart';
import 'package:anime_app/features/auth/data/dto/register_dto.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(String baseUrl)
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://6a72-95-87-69-211.ngrok-free.app',
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );

  Future<void> registerUser(RegisterDto user) async {
    try {
      final response = await dio.post('/register', data: user.toJson());
      if (response.statusCode != 201) {
        throw Exception(response.data['message'] ?? 'Неизвестная ошибка');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
        print('Response status: ${e.response?.statusCode}');
        throw Exception(e.response?.data['message'] ?? 'Ошибка на сервере');
      } else {
        throw Exception('Ошибка сети: ${e.message}');
      }
    }
  }

  Future<Map<String, dynamic>> loginUser(LoginDto user) async {
    try {
      print(user.toJson());
      final response = await dio.post('/login', data: user.toJson());

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data['message'] ?? 'Ошибка авторизации');
      }
    } catch (e) {
      throw Exception('Ошибка сети: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> fetchUserProfile(String username) async {
    try {
      final response = await dio.get('/profile/$username');
      return response.data;
    } on DioException catch (e) {
      throw Exception('Ошибка загрузки профиля');
    }
  }
}
