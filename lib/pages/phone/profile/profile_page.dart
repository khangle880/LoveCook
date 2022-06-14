import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lovecook/utils/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../router/router.dart';
import '../../../widgets/widgets.dart';
import '../follow/follow_page.dart';

class ProfilePage extends StatefulWidget {
  final ProfileBloc bloc;
  final SharedPreferences sharedPreferences;

  const ProfilePage(this.bloc, this.sharedPreferences);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseState<ProfilePage, ProfileBloc> {
  bool isMe = false;

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
                ProfileStackBackground(
                  imageUrl: user_data.avatarUrl != null
                      ? AppConfig.instance.formatLink(user_data.avatarUrl!)
                      : null,
                ),
                Row(
                  children: [
                    OutlineButton(
                      color: Colors.amberAccent,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.follow,
                          arguments: user_data,
                        );
                      },
                      text: user_data.followingUsers!.length.toString() +
                          " Following",
                    ),
                    OutlineButton(
                      color: Colors.cyan,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.follow,
                          arguments: user_data,
                        );
                      },
                      text: user_data.followerUsers!.length.toString() +
                          " Follower",
                    ),
                    if (!isMe)
                      FollowButton(
                        initIsFollowed: bloc.state!.loggedUser!.followingUsers!
                            .contains(user_data.id),
                        onTap: (bool follow) {
                          bloc.handleFollow(user_data, follow);
                        },
                      )
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       OutlineButton(
                //         color: Colors.amberAccent,
                //         onPressed: () {
                //           Navigator.pushNamed(context, Routes.recipes,
                //               arguments: user_data);
                //         },
                //         text: user_data.totalRecipes.toString() + " Recipes",
                //       ),
                //       OutlineButton(
                //         color: Colors.cyan,
                //         onPressed: () {
                //           Navigator.pushNamed(context, Routes.posts,
                //               arguments: user_data);
                //         },
                //         text: user_data.totalPosts.toString() + " Posts",
                //       ),
                //       OutlineButton(
                //         color: Colors.lightGreen,
                //         onPressed: () {
                //           Navigator.pushNamed(context, Routes.products,
                //               arguments: user_data);
                //         },
                //         text: user_data.totalProducts.toString() + " Products",
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: ProfileBottom(
                    isMe: isMe,
                    user: user_data,
                    changeName: (username) {
                      bloc.changeProfile(profile: {'name': username});
                    },
                    changePhone: (phone) {
                      bloc.changeProfile(profile: {'phone': phone});
                    },
                    changeLanguage: (language) {
                      bloc.changeProfile(
                          profile: {'languageSetting': language});
                    },
                  ),
                )
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
