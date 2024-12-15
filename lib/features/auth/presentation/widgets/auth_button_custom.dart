import 'package:anime_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:anime_app/features/auth/presentation/bloc/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AuthButtonCustom {
  static ButtonStyle _defaultStyle(BuildContext context) {
    return const ButtonStyle(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero))));
  }

  static Widget signUp({
    required BuildContext context,
    required TextEditingController controlEmail,
    required TextEditingController controlPassword,
    required TextEditingController controlName,
  }) {
    return ElevatedButton(
      style: _defaultStyle(context),
      onPressed: () {
        Provider.of<UserProvider>(context, listen: false)
            .setUser(controlName.text);
        context.read<AuthBloc>().add(
              RegisterUserEvent(
                image: '',
                email: controlEmail.text,
                password: controlPassword.text,
                name: controlName.text,
              ),
            );
      },
      child: const Text('Зарегистрироваться'),
    );
  }

  static Widget login({
    required BuildContext context,
    required TextEditingController controlPassword,
    required TextEditingController controlName,
  }) {
    return ElevatedButton(
      style: _defaultStyle(context),
      onPressed: () {
        Provider.of<UserProvider>(context, listen: false)
            .setUser(controlName.text);
        context.read<AuthBloc>().add(
              LoginUserEvent(
                password: controlPassword.text,
                name: controlName.text,
              ),
            );
      },
      child: const Text('Войти'),
    );
  }
}
