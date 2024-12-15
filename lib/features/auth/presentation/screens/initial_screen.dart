import 'package:anime_app/core/routes/app_router.gr.dart';
import 'package:anime_app/core/style/app_images.dart';
import 'package:anime_app/core/style/app_margins.dart';
import 'package:anime_app/core/utils/app_theme_util.dart';
import 'package:anime_app/core/utils/media_query_extension.dart';
import 'package:anime_app/features/auth/presentation/widgets/auth_button_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          Positioned(
              top: context.screenHeight * 0.10,
              right: 0,
              left: 0,
              child: Image.asset(
                AppImages.logo,
                height: 70,
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacer.large),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: context.screenWidth * 0.4,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))))),
                          onPressed: () {
                            context.pushRoute(SignInRoute());
                          },
                          child: const Text('Войти')),
                    ),
                    SizedBox(
                      height: 50,
                      width: context.screenWidth * 0.4,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(context.primaryColor),
                              foregroundColor: WidgetStatePropertyAll(
                                  context.backgroundColor),
                              shape: const WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))))),
                          onPressed: () {
                            context.pushRoute(const SignUpRoute());
                          },
                          child: const Text('Регистрация')),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
