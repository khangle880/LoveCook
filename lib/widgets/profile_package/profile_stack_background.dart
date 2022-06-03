import 'package:flutter/material.dart';

import 'profile_package.dart';

class ProfileStackBackground extends StatefulWidget {
  final String? imageUrl;

  const ProfileStackBackground({Key? key, this.imageUrl}) : super(key: key);

  @override
  State<ProfileStackBackground> createState() => _ProfileStackBackgroundState();
}

class _ProfileStackBackgroundState extends State<ProfileStackBackground> {
  late String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Stack(
        children: <Widget>[
          Container(),
          ClipPath(
            // clipper: ProfileClipper(),
            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_imageUrl != null && _imageUrl!.isNotEmpty
                      ? _imageUrl!
                      : "https://i.pravatar.cc/400"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // CircularProfileAvatar(
                //   "https://i.pravatar.cc/300",
                //   borderWidth: 4.0,
                //   radius: 60.0,
                // ),
                SizedBox(height: 4.0),
                // Text(
                //   "Neecoder X",
                //   style: TextStyle(
                //     fontSize: 21.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // Text(
                //   "Developer",
                //   style: TextStyle(
                //     fontSize: 12.0,
                //     color: Colors.grey[700],
                //   ),
                // ),
              ],
            ),
          ),
          ProfileTopBar(),
        ],
      ),
    );
  }
}
