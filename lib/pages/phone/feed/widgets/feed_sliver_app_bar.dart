import 'package:flutter/material.dart';

import '../../../../data/data.dart';
import '../../../../extensions/extensions.dart';
import '../../../../resources/colors.dart';
import '../../../../widgets/widgets.dart';

class FeedSliverAppBar extends StatelessWidget {
  final User? userInfor;
  final bool isHomeFeed;
  final Function(String, List<String>, String?)? onPostCall;
  final Function(String)? onSearchCall;

  FeedSliverAppBar(
      {this.userInfor,
      this.onPostCall,
      this.onSearchCall,
      this.isHomeFeed = true});

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
          ? userInfor!.name!.s20w700(color: AppColors.successDarken)
          : Text(''),
      centerTitle: false,
      floating: true,
      actions: [
        if (isHomeFeed) ...[
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
            onPressed: () {
              ShowCustomBottomSheet.searchPost(context, onSearchCall);
            },
          )
        ] else
          CircleButton(
            icon: Icons.close,
            iconSize: 30.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        SizedBox(width: 12.0)
      ],
    );
  }
}
