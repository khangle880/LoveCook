import 'package:flutter/material.dart';

import '../../../../blocs/blocs.dart';
import '../../../../core/core.dart';
import '../../../../resources/resources.dart';
import '../../../../router/router.dart';
import '../../../../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  final LoginBloc bloc;

  const LoginPage(this.bloc);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginBloc> {
  String email = '';
  String password = '';

  @override
  void initData() {
    super.initData();
  }

  @override
  bool get isCustomLayout => true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final model = Provider.of<TextFieldModel>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height - 200,
            color: AppColors.mediumBlue,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3.0,
              color: AppColors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Topa',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextFieldOutline(
                  hintText: 'Email',
                  obscureText: false,
                  prefixIconData: Icons.mail_outline,
                  // suffixIconData: model.isValid ? Icons.check : null,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFieldOutline(
                      hintText: 'Password',
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      prefixIconData: Icons.lock_outline,
                      // suffixIconData: model.isVisible
                      //     ? Icons.visibility
                      //     : Icons.visibility_off,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: AppColors.mediumBlue,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                MaterialInkwellButton(
                  title: 'Login',
                  hasBorder: false,
                  onTap: () {
                    // bloc.login(email, password);
                    Navigator.pushNamed(context, Routes.home);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                MaterialInkwellButton(
                  title: 'Sign Up',
                  hasBorder: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void blocListener(state) {
    super.blocListener(state);
  }

  @override
  LoginBloc get bloc => widget.bloc;
}
