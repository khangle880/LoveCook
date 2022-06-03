import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

class NetworkAvatar extends StatelessWidget {
  const NetworkAvatar(
      {Key? key,
      this.link,
      this.decoration,
      this.height = 30.0,
      this.width = 30.0,
      this.borderRadius = 50.0,
      this.placehouderText = "error",
      this.margin,
      this.padding})
      : super(key: key);

  final String? link;
  final double height;
  final double width;
  final double borderRadius;
  final String placehouderText;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: decoration,
        margin: margin,
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: (link != null && link! != "")
              ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: link!,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Assets.images.svg.icDefaultAvatar.svg(),
          // child: Center(child: Text(placehouderText)),
        ));
  }
}
