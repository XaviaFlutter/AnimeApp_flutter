import 'package:anime_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:anime_app/features/auth/data/dto/login_dto.dart';
import 'package:anime_app/features/auth/data/dto/register_dto.dart';
import 'package:anime_app/features/auth/domain/entity/auth_entity.dart';
import 'package:anime_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  Future<void> registerUser(RegisterDto user) async {
    try {
      await authRemoteDataSource.registerUser(user);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AuthEntity> fetchUserProfile(String username) async {
    try {
      final data = await authRemoteDataSource.fetchUserProfile(username);
      final user = data['user'];
      return AuthEntity(
          email: user['email'],
          password: '',
          avatar: user['avatar'],
          name: user['name']);
    } catch (e) {
      throw Exception('ошибка получение профиля $e');
    }
  }

  Future<AuthEntity> loginUser(LoginDto user) async {
    try {
      final data = await authRemoteDataSource.loginUser(user);
      final dto = LoginDto.fromJson(data);
      return dto.toEntity();
    } catch (e) {
      throw Exception('Ошибка авторизации: ${e.toString()}');
    }
  }
}
