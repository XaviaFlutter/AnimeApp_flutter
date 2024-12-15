import 'package:anime_app/features/auth/data/dto/login_dto.dart';
import 'package:anime_app/features/auth/domain/entity/auth_entity.dart';
import 'package:anime_app/features/auth/domain/repository/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository repository;

  LoginUserUseCase(this.repository);

  Future<AuthEntity> call(LoginDto dto) async {
    if (dto.name.isEmpty || dto.password.isEmpty) {
      throw Exception('Имя и пароль не могут быть пустыми');
    }
    return await repository.loginUser(dto);
  }
}
