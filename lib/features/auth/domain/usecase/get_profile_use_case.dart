import 'package:anime_app/features/auth/domain/entity/auth_entity.dart';
import 'package:anime_app/features/auth/domain/repository/auth_repository.dart';

class GetProfileUseCase {
  final AuthRepository authRepository;

  GetProfileUseCase({required this.authRepository});

  Future<AuthEntity> call(String username) async {
    return await authRepository.fetchUserProfile(username);
  }
}
