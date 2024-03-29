import 'package:flutter/material.dart';
import 'package:lovecook/widgets/app_dialog/app_dialog.dart';

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
  final _formKey = GlobalKey<FormState>();

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
            color: AppColors.successDarken,
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
                  'Love Cook',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextFormFieldOutline(
                    hintText: 'Email',
                    prefixIconData: Icons.mail_outline,
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if ((value ?? '').isEmpty) return 'Email not empty';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormFieldOutline(
                    onChanged: (value) {
                      password = value;
                    },
                    hintText: 'Password',
                    validator: (value) {
                      if ((value ?? '').isEmpty) return 'Password not empty';
                      return null;
                    },
                    isObscureEnable: true,
                    prefixIconData: Icons.lock_outline,
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
                  SizedBox(
                    height: 20.0,
                  ),
                  MaterialInkwellButton(
                      title: 'Login',
                      hasBorder: false,
                      backgroundColor: AppColors.successNormal,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          bloc.login(email, password).catchError(
                            (e) {
                              return showDialog(
                                context: context,
                                builder: (context) =>
                                    AppInformationDialog(content: e),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => AppInformationDialog(
                                content:
                                    "You need fullfill form before submit!"),
                          );
                        }
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  MaterialInkwellButton(
                    title: 'Sign Up',
                    hasBorder: true,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          Routes.register, (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void blocListener(state) {
    if (mounted) {
      super.blocListener(state);
      if (state.success) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (Route<dynamic> route) => false);
      }
    }
  }

  @override
  LoginBloc get bloc => widget.bloc;
}
