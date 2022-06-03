import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../gen/assets.gen.dart';

class AvatarContainer extends StatelessWidget {
  final Text? text;
  final bool isOnlyText;
  final double radius;
  final double borderWidth;
  final String imagePath;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? placeHolder;
  final Widget? errorWidget;

  const AvatarContainer(
      {Key? key,
      this.radius = 50,
      this.borderWidth = 0,
      required this.imagePath,
      this.backgroundColor,
      this.foregroundColor,
      this.borderColor,
      this.placeHolder,
      this.errorWidget,
      this.text,
      this.isOnlyText = false})
      : super(key: key);

  Widget getTextWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
          padding: EdgeInsets.all(borderWidth),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: backgroundColor),
          child: Center(child: text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: radius * 2,
        width: radius * 2,
        padding: EdgeInsets.all(borderWidth),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: borderColor),
        child: isOnlyText
            ? getTextWidget()
            : imagePath.isEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: Container(
                      color: backgroundColor,
                      child: Assets.images.svg.icUserFollow
                          .svg(width: 24, height: 24),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: imagePath.contains("http")
                        ? CachedNetworkImage(
                            imageUrl: imagePath,
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return placeHolder ??
                                  Container(
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                  );
                            },
                            errorWidget: (context, url, error) {
                              return errorWidget ??
                                  Container(
                                    child: Icon(
                                      Icons.error,
                                      size: 50,
                                    ),
                                  );
                            },
                          )
                        : Image.asset(imagePath, fit: BoxFit.cover),
                  ),
      ),
    );
  }
}
