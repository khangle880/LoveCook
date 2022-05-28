import 'package:flutter/material.dart';

import '../data/responses/responses.dart';
import 'widgets.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatar(
              imageUrl: user.avatarUrl ?? 'http://via.placeholder.com/350x150'),
          const SizedBox(width: 6.0),
          Flexible(
            child: Text(
              user.name ?? 'Not found name',
              style: const TextStyle(fontSize: 16.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
