import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  final ProfileBloc bloc;
  final SharedPreferences sharedPreferences;

  const ProfilePage(this.bloc, this.sharedPreferences);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseState<ProfilePage, ProfileBloc> {
  @override
  void initState() {
    super.initState();
    bloc.checkProfile();
  }

  @override
  bool get isCustomLayout => true;

  SharedPreferences get sharedPreferences => widget.sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: bloc.user,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final user_data = snapshot.data;

            return Column(
              children: <Widget>[
                ProfileStackBackground(
                  imageUrl: user_data?.avatarUrl,
                ),
                Expanded(
                    child: ProfileBottom(
                  user: user_data,
                  changeName: (username) {
                    bloc.changeProfile(profile: {'name': username});
                  },
                  changePhone: (phone) {
                    bloc.changeProfile(profile: {'phone': phone});
                  },
                  changeLanguage: (language) {
                    bloc.changeProfile(profile: {'languageSetting': language});
                  },
                ))
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
