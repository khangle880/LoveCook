import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../data/data.dart';
import '../../router/router.dart';
import 'post_package.dart';

class PostHeader extends StatelessWidget {
  final PostModel? post;

  const PostHeader({
    this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.profile,
                arguments: post?.creator,
              );
            },
            child: ProfileAvatar(imageUrl: post?.creator?.avatarUrl)),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post?.creator?.name ?? 'User',
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black),
              ),
              Row(
                children: [
                  Text(
                    timeago.format(post?.createdAt ?? DateTime.now()),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => print('More'),
        ),
      ],
    );
  }
}
