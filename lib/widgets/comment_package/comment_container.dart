import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../data/data.dart';
import '../../extensions/extensions.dart';
import '../widgets.dart';

class CommentContainer extends StatefulWidget {
  final CommentModel? comment;

  const CommentContainer({Key? key, required this.comment}) : super(key: key);

  @override
  State<CommentContainer> createState() => _CommentContainerState();
}

class _CommentContainerState extends State<CommentContainer> {
  CommentModel? get comment => widget.comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Row(
        children: <Widget>[
          ProfileAvatar(
              imageUrl:
                  comment?.creator?.avatarUrl ?? 'https://i.pravatar.cc/400'),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  (comment?.creator?.name ?? 'User')
                      .s14w600(color: Colors.black),
                  ' - '.s14w600(color: Colors.grey),
                  (timeago.format(comment?.createdAt ?? DateTime.now()))
                      .s13w400(color: Colors.grey)
                ],
              ),
              SizedBox(height: 4),
              (comment?.content ?? '').s14w500(),
              SizedBox(height: 7),
              Container(
                height: 14,
                child: ReactionButtonToggle(
                    onReactionChanged: (value, changed) {},
                    // itemScale: 1,
                    reactions: reactions),
              ),
            ],
          )
        ],
      ),
    );
  }
}
