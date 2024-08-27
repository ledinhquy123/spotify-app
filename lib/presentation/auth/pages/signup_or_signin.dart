import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/common/appbar/app_bar.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/common/widgets/buttons/basic_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/presentation/auth/pages/signin.dart';
import 'package:spotify_project/presentation/auth/pages/signup.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final kW = MediaQuery.of(context).size.width;
    final kH = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          const BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBG),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kW * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.logo),
                  SizedBox(height: kH * 0.05),
                  const Text(
                    'Enjoy Listening To Music',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  SizedBox(height: kH * 0.025),
                  const Text(
                    'Spotify is a proprietary Swedish audio streaming and media services provider',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff797979)),
                  ),
                  SizedBox(height: kH * 0.025),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: BasicAppButton(
                              onPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SignupPage()));
                              },
                              title: 'Register',
                              height: kH * 0.1)),
                      SizedBox(width: kW * 0.08),
                      Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SigninPage()));
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500),
                              )))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
