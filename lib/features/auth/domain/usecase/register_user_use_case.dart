import 'package:anime_app/features/auth/data/dto/register_dto.dart';
import 'package:anime_app/features/auth/domain/repository/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository authRepository;

  RegisterUserUseCase(this.authRepository);

  Future<void> call(RegisterDto dto) async {
    if (dto.password.isEmpty || dto.email.isEmpty || dto.name.isEmpty) {
      throw Exception('Все поля не должны быть пустыми');
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(dto.email)) {
      throw Exception('Неправильный email');
    }
    if (dto.password.length < 6) {
      throw Exception('Пароль должен содержать минимум 6 символов');
    }
    await authRepository.registerUser(dto);
  }
}
