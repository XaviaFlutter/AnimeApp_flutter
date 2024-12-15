import 'dart:ui';

import 'package:anime_app/core/routes/app_router.gr.dart';
import 'package:anime_app/core/service/auth_service.dart';
import 'package:anime_app/core/style/app_images.dart';
import 'package:anime_app/core/utils/media_query_extension.dart';
import 'package:anime_app/features/auth/presentation/bloc/user_provider.dart';

import 'package:anime_app/features/auth/presentation/widgets/auth_button_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anime_app/core/style/app_margins.dart';
import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:anime_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:anime_app/features/auth/presentation/widgets/auth_text_field_custom.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final AuthServiceAndroid _authService = AuthServiceAndroid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: Consumer<UserProvider>(
        builder: (context, provider, _) => Stack(
          children: [
            ImageFiltered(
              imageFilter: ColorFilter.mode(
                  context.backgroundColor.withValues(alpha: 0.7),
                  BlendMode.multiply),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppImages.wallpaper_one))),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: context.backgroundColor.withValues(alpha: 0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacer.medium),
              child: TextButton.icon(
                  onPressed: () {
                    context.maybePop();
                  },
                  label: const Icon(Icons.arrow_back_ios)),
            ),
            Positioned.fill(
              top: context.screenHeight * 0.2,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacer.medium),
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      context.router.push(HomeRoute());
                    } else if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message.toString())));
                    }
                  },
                  child: Column(
                    children: [
                      Wrap(
                        spacing: AppSpacer.medium,
                        runSpacing: AppSpacer.medium,
                        children: [
                          AuthTextFieldCustom.name(
                              controller: nameController, context: context),
                          AuthTextFieldCustom.email(
                              controller: emailController, context: context),
                          AuthTextFieldCustom.password(
                              controller: passwordController, context: context),
                        ],
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator();
                          }

                          return AuthButtonCustom.signUp(
                            context: context,
                            controlEmail: emailController,
                            controlName: nameController,
                            controlPassword: passwordController,
                          );
                        },
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final authService = AuthServiceAndroid();
                            final user = await authService.signInWithGoogle();

                            if (user != null) {
                              print('Вход выполнен: ${user.displayName}');
                              context.read<AuthBloc>().add(RegisterUserEvent(
                                  image: user.photoURL.toString(),
                                  email: user.email.toString(),
                                  password: user.uid.toString(),
                                  name: user.displayName.toString()));
                              provider.setUser(user.displayName.toString());
                              context.router.push(HomeRoute());
                            } else {
                              print('Вход отменён.');
                            }
                          },
                          child: const Icon(Icons.anchor))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
