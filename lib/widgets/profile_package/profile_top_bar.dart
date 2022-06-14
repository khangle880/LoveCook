import 'package:flutter/material.dart';

class ProfileTopBar extends StatelessWidget {
  final bool isOwner;

  const ProfileTopBar({required this.isOwner});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          isOwner
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu, color: Colors.white),
                )
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
