import 'package:anime_app/features/auth/data/dto/login_dto.dart';
import 'package:anime_app/features/auth/data/dto/register_dto.dart';
import 'package:anime_app/features/auth/domain/entity/auth_entity.dart';

abstract class AuthRepository {
  Future<void> registerUser(RegisterDto user);
  Future<AuthEntity> loginUser(LoginDto user);
  Future<AuthEntity> fetchUserProfile(String username);
}
