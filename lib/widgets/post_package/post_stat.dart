import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../data/data.dart';
import '../widgets.dart';

class PostStats extends StatelessWidget {
  final PostModel? post;
  final VoidCallback? onCommentPress;
  final Function(String?)? onReactChange;

  const PostStats(
      {Key? key, this.post, this.onCommentPress, this.onReactChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ReactionButtonToggle(
                  initialReaction: extracEmoteValue(post?.statusWithMe),
                  onReactionChanged: (value, changed) {
                    onReactChange?.call(value as String);
                  },
                  reactions: reactions),
            ),
            PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Comment',
              onTap: onCommentPress,
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

  Reaction<String>? extracEmoteValue(StatusWithMe? status) {
    switch (status?.reaction?.type) {
      case null:
        return null;
      case "Empty":
        return null;
      case "Happy":
        return reactions[1];
      case "Angry":
        return reactions[2];
      case "In love":
        return reactions[3];
      case "Sad":
        return reactions[4];
      case "Suprised":
        return reactions[5];
      case "Mad":
        return reactions[6];
      default:
        return null;
    }
  }
}
