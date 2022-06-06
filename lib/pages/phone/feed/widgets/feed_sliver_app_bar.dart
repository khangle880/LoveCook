import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../../extensions/extensions.dart';
import '../../../../widgets/widgets.dart';

class FeedSliverAppBar extends StatelessWidget {
  final User? userInfor;
  final Function(String, List<String>)? onPostCall;

  FeedSliverAppBar({this.userInfor, this.onPostCall});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 7.0),
        child: ProfileAvatar(
            imageUrl: userInfor!.avatarUrl!.isEmpty
                ? "https://i.pravatar.cc/300"
                : userInfor!.avatarUrl!),
      ),
      title: userInfor?.name != null
          ? userInfor!.name!.s20w700(color: Color(0xFF646FD4))
          : Text(''),
      centerTitle: false,
      floating: true,
      actions: [
        CircleButton(
          icon: Icons.add,
          iconSize: 30.0,
          onPressed: () {
            ShowCustomBottomSheet.addPost(
              context,
              userInfor,
              onPostCall,
            );
          },
        ),
        CircleButton(
          icon: Icons.search,
          iconSize: 30.0,
          onPressed: () => print('Search'),
        ),
      ],
    );
  }
}
