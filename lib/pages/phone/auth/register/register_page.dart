import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lovecook/blocs/register/register_bloc.dart';
import 'package:lovecook/widgets/app_dialog/app_dialog.dart';

import '../../../../blocs/blocs.dart';
import '../../../../core/core.dart';
import '../../../../resources/resources.dart';
import '../../../../router/router.dart';
import '../../../../widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  final RegisterBloc bloc;

  const RegisterPage(this.bloc);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterBloc> {
  String email = '';
  String password = '';
  String confirmPassword = '';
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
                  TextFormFieldOutline(
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    hintText: 'Confirm Password',
                    validator: (value) {
                      if ((value ?? '').isEmpty) return 'Confirm password not empty';
                      if ((value ?? '') != password)
                        return 'Password not match';
                      return null;
                    },
                    isObscureEnable: true,
                    prefixIconData: Icons.lock_outline,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MaterialInkwellButton(
                      title: 'Register',
                      hasBorder: false,
                      backgroundColor: AppColors.successNormal,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          bloc.register(email, password).catchError(
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
                    title: 'Login',
                    hasBorder: true,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, Routes.login,
                          (Route<dynamic> route) => false);
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
  RegisterBloc get bloc => widget.bloc;
}
