import 'package:flutter/material.dart';

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
