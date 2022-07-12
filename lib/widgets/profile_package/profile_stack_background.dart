import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../blocs/profile/profile_bloc.dart';
import 'profile_package.dart';

class ProfileStackBackground extends StatefulWidget {
  final String? imageUrl;
  final bool isOwner;
  final ProfileBloc bloc;

  const ProfileStackBackground({
    Key? key,
    this.imageUrl,
    required this.isOwner,
    required this.bloc,
  }) : super(key: key);

  @override
  State<ProfileStackBackground> createState() => _ProfileStackBackgroundState();
}

class _ProfileStackBackgroundState extends State<ProfileStackBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Stack(
        children: <Widget>[
          Container(),
          CachedNetworkImage(
            imageUrl: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                ? widget.imageUrl!
                : "https://i.pravatar.cc/400",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                value: progress.progress,
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
          ProfileTopBar(
            bloc: widget.bloc,
            isOwner: widget.isOwner,
          ),
        ],
      ),
    );
  }
}
