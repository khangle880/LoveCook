import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/responses/responses.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    required this.message,
  });

  final ChatMessageResponse message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45, // 45% of total width
      child: AspectRatio(
        aspectRatio: 1.6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
              imageUrl: message.image ??
                  'https://gravatar.com/avatar/2422869ca1435286e660ccf11ae895bd?s=400&d=robohash&r=x'),
        ),
      ),
    );
  }
}
