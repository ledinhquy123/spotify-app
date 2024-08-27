import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/common/widgets/buttons/basic_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/auth/pages/signup_or_signin.dart';
import 'package:spotify_project/presentation/choose_mode/bloc/them_cubit.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.chooseModeBG),
                    fit: BoxFit.fill)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            color: Colors.black.withOpacity(.15),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AppVectors.logo)),
                const Spacer(),
                const Text(
                  'Choose Mode',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xffDADADA)),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ThemeCubit>()
                                .updateTheme(ThemeMode.dark);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    color:
                                        const Color(0xff30393C).withOpacity(.5),
                                    shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                  AppVectors.moon,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Dark Mode',
                            style: TextStyle(
                                fontSize: 17,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                    const SizedBox(width: 100),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ThemeCubit>()
                                .updateTheme(ThemeMode.light);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    color:
                                        const Color(0xff30393C).withOpacity(.5),
                                    shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                  AppVectors.sun,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Light Mode',
                            style: TextStyle(
                                fontSize: 17,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500))
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 50),
                BasicAppButton(
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SignupOrSigninPage()));
                    },
                    title: 'Continue')
              ],
            ),
          )
        ],
      ),
    );
  }
}
