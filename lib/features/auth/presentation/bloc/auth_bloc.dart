import 'package:anime_app/features/auth/data/dto/login_dto.dart';
import 'package:anime_app/features/auth/data/dto/register_dto.dart';
import 'package:anime_app/features/auth/domain/entity/auth_entity.dart';
import 'package:anime_app/features/auth/domain/usecase/get_profile_use_case.dart';
import 'package:anime_app/features/auth/domain/usecase/login_user_use_case.dart';
import 'package:anime_app/features/auth/domain/usecase/register_user_use_case.dart';
import 'package:anime_app/features/auth/presentation/bloc/user_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetProfileUseCase getProfileUseCase;
  final RegisterUserUseCase registerUserUseCase;
  final LoginUserUseCase loginUserUseCase;
  AuthBloc(
      this.registerUserUseCase, this.loginUserUseCase, this.getProfileUseCase)
      : super(AuthInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<LoginUserEvent>(_onLoginUser);
    on<GetUserProfileEvent>(_onGetUserProfile);
  }

  Future<void> _onGetUserProfile(
      GetUserProfileEvent event, Emitter<AuthState> emit) async {
    try {
      final profile = await getProfileUseCase.call(event.username);
      print('profile $profile');
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(AuthFailure(message: '$e'));
    }
  }

  Future<void> _onRegisterUser(
      RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final dto = RegisterDto(
        avatar: event.image,
        email: event.email,
        password: event.password,
        name: event.name,
      );
      await registerUserUseCase.call(dto);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onLoginUser(
      LoginUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final dto = LoginDto(
        name: event.name,
        password: event.password,
      );
      await loginUserUseCase.call(dto);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
