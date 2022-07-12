import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:lovecook/blocs/profile/profile_bloc.dart';

import '../../resources/colors.dart';
import '../../router/router.dart';
import '../../utils/media_pick.dart';
import '../bottom_sheet_package/bottom_sheet_package.dart';

class ProfileTopBar extends StatelessWidget {
  final bool isOwner;
  final ProfileBloc bloc;

  const ProfileTopBar({
    required this.isOwner,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          isOwner
              ? FocusedMenuHolder(
                  menuWidth: MediaQuery.of(context).size.width / 3 + 10,
                  blurSize: 0.0,
                  menuItemExtent: 50,
                  menuBoxDecoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  duration: Duration(milliseconds: 100),
                  animateMenuItems: true,
                  blurBackgroundColor: AppColors.bgNormal,
                  menuOffset: 10.0,
                  bottomOffsetHeight: 80.0,
                  openWithTap: true,
                  onPressed: () {},
                  menuItems: <FocusedMenuItem>[
                    FocusedMenuItem(
                        title: Text("Update avatar"),
                        trailingIcon: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          var imagePath = await singleImagePick(context);

                          if (imagePath != null) {
                            bloc.updateAvatar(imagePath);
                          }
                        }),
                    FocusedMenuItem(
                        title: Text("Update bio"),
                        trailingIcon: Icon(
                          Icons.create,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          ShowCustomBottomSheet.changeBio(context, (bio) {
                            bloc.changeProfile(profile: {'bio': bio});
                          });
                        }),
                    FocusedMenuItem(
                        title: Text("Logout"),
                        trailingIcon: Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          bloc.logout().then((value) =>
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.login,
                                  (Route<dynamic> route) => false));
                        }),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.menu, color: Colors.white),
                  ))
              : IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: Colors.white),
                ),
        ],
      ),
    );
  }
}
