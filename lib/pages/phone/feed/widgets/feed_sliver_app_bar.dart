import 'package:flutter/material.dart';

import '../../../../extensions/extensions.dart';
import '../../../../widgets/widgets.dart';

class FeedSliverAppBar extends StatelessWidget {
  final String? avtarUrl;
  final String? userName;

  FeedSliverAppBar(this.avtarUrl, this.userName);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 7.0),
        child: ProfileAvatar(
            imageUrl:
                avtarUrl!.isEmpty ? "https://i.pravatar.cc/300" : avtarUrl!),
      ),
      title: userName != null
          ? userName!.s20w700(color: Color(0xFF646FD4))
          : Text(''),
      centerTitle: false,
      floating: true,
      actions: [
        CircleButton(
          icon: Icons.add,
          iconSize: 30.0,
          onPressed: () => print('Search'),
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
