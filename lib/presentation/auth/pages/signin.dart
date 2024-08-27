import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/common/appbar/app_bar.dart';
import 'package:spotify_project/common/widgets/buttons/basic_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';
import 'package:spotify_project/domain/usecases/auth/signin.dart';
import 'package:spotify_project/presentation/auth/pages/signup.dart';
import 'package:spotify_project/presentation/home/pages/home.dart';
import 'package:spotify_project/service_locator.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final kW = MediaQuery.of(context).size.width;
    final kH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: kH * 0.05,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: _signupText(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: kW * 0.1, vertical: kW * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _registerText(),
            SizedBox(height: kH * 0.05),
            _emailField(context),
            SizedBox(height: kH * 0.03),
            _passwordField(context),
            SizedBox(height: kH * 0.03),
            BasicAppButton(
                onPress: () async {
                  var result = await sl<SignInUseCase>().call(
                      params: SigninUserReq(
                          email: _email.text, password: _password.text));
                  result.fold((l) {
                    var snackbar = SnackBar(content: Text(l));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar,
                        snackBarAnimationStyle: AnimationStyle(
                            curve: Curves.easeInOut,
                            duration: const Duration(seconds: 1)));
                  }, (r) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const HomePage()),
                        (route) => false);
                  });
                },
                title: 'Sign In')
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
        controller: _email,
        decoration: const InputDecoration(hintText: 'Enter Email')
            .applyDefaults(Theme.of(context).inputDecorationTheme));
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
        controller: _password,
        decoration: const InputDecoration(hintText: 'Password')
            .applyDefaults(Theme.of(context).inputDecorationTheme));
  }

  Widget _signupText(BuildContext context) {
    final kH = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: kH * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member?',
            style: TextStyle(
                color: Color(0xff383838),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignupPage()));
              },
              child: const Text(
                'Register Now',
                style: TextStyle(
                    color: Color(0xff288CE9),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }
}
