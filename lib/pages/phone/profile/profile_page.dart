import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lovecook/utils/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../router/router.dart';
import '../../../widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  final ProfileBloc bloc;
  final SharedPreferences sharedPreferences;

  const ProfilePage(this.bloc, this.sharedPreferences);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseState<ProfilePage, ProfileBloc> {
  bool isMe = false;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void onReceivePayload(Object? payload) {
    super.onReceivePayload(payload);
    if (payload is User) {
      bloc.setUser(payload);
      isMe = false;
    } else {
      bloc.checkProfile();
      isMe = true;

      GetIt.I.get<AppBloc>().followStream.listen((event) {
        bloc.checkProfile();
      });
    }
  }

  @override
  bool get isCustomLayout => true;

  SharedPreferences get sharedPreferences => widget.sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<User?>(
          stream: bloc.user,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final user_data = snapshot.data!;

            return Column(
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      bloc.logout().then((value) =>
                          Navigator.pushNamedAndRemoveUntil(context,
                              Routes.login, (Route<dynamic> route) => false));
                    },
                    child: Text("logout")),
                ProfileStackBackground(
                  isOwner: isMe,
                  imageUrl: user_data.avatarUrl != null
                      ? AppConfig.instance.formatLink(user_data.avatarUrl!)
                      : null,
                ),
                Expanded(
                  child: VisibilityDetector(
                    onVisibilityChanged: (info) {
                      if (!_isVisible && info.visibleFraction > 0.1) {
                        bloc.checkProfile();
                      }
                      _isVisible = info.visibleFraction > 0.1;
                    },
                    key: UniqueKey(),
                    child: ProfileBottom(
                      isMe: isMe,
                      user: user_data,
                      bloc: bloc,
                      changeName: (username) {
                        bloc.changeProfile(profile: {'name': username});
                      },
                      changePhone: (phone) {
                        bloc.changeProfile(profile: {'phone': phone});
                      },
                      changeLanguage: (language) {
                        bloc.changeProfile(
                            profile: {'languageSetting': language});
                        GetIt.I.get<AppBloc>().clearMessage();
                      },
                    ),
                  ),
                ),

                // ProfileCard(),
                // ProfileCard(),
                // ProfileCard(),
              ],
            );
          }),
    );
  }

  @override
  ProfileBloc get bloc => widget.bloc;
}
