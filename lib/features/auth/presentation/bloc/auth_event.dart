part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class RegisterUserEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String image;
  RegisterUserEvent(
      {required this.image,
      required this.email,
      required this.password,
      required this.name});
}

class LoginUserEvent extends AuthEvent {
  final String name;
  final String password;

  LoginUserEvent({required this.name, required this.password});
}

class GetUserProfileEvent extends AuthEvent {
  final String username;

  GetUserProfileEvent({required this.username});
}
