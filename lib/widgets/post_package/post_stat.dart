import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:lovecook/resources/colors.dart';
import 'package:lovecook/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../data/data.dart';
import 'post_package.dart';

class PostStats extends StatelessWidget {
  final PostModel? post;

  const PostStats({
    Key? key,
    this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Row(
        //   children: [
        //     Container(
        //       padding: const EdgeInsets.all(4.0),
        //       decoration: BoxDecoration(
        //         color: AppColors.facebookBlue,
        //         shape: BoxShape.circle,
        //       ),
        //       child: const Icon(
        //         Icons.thumb_up,
        //         size: 10.0,
        //         color: Colors.white,
        //       ),
        //     ),
        //     const SizedBox(width: 4.0),
        //     Text(
        //       'Comments',
        //       style: TextStyle(
        //         color: Colors.grey[600],
        //       ),
        //     ),
        //     const SizedBox(width: 8.0),
        //     Text(
        //       'Shares',
        //       style: TextStyle(
        //         color: Colors.grey[600],
        //       ),
        //     )
        //   ],
        // ),
        const Divider(),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ReactionButtonToggle(
                  onReactionChanged: (value, changed) {}, reactions: reactions),
            ),
            // PostButton(
            //   icon: Icon(
            //     MdiIcons.thumbUpOutline,
            //     color: Colors.grey[600],
            //     size: 20.0,
            //   ),
            //   label: 'Like',
            //   onTap: () => print('Like'),
            // ),
            PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Comment',
              onTap: () => print('Comment'),
            ),
            PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Share',
              onTap: () => print('Share'),
            )
          ],
        ),
      ],
    );
  }
}
