import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../resources/resources.dart';

class PhotoItem extends StatelessWidget {
  final dynamic dataImage;
  final void Function(dynamic)? onDeleteImageClick;
  final bool disable;
  final double size;
  final double radius;

  PhotoItem({
    Key? key,
    @required this.dataImage,
    this.onDeleteImageClick,
    this.disable = false,
    this.radius = 4,
    this.size = 44,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageWidget = dataImage is String
        ? _buildUrlImage(dataImage)
        : _buildAssetImage(dataImage);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, right: 10, bottom: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: SizedBox(
              width: size,
              height: size,
              child: imageWidget,
            ),
          ),
        ),

        /// Show delete icon
        disable ? Container() : _deleteIcon(dataImage),
      ],
    );
  }

  Widget _buildAssetImage(dynamic dataImage) {
    return Image.memory(
      dataImage as Uint8List,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildUrlImage(dynamic dataImage) {
    return CachedNetworkImage(
      imageUrl: dataImage as String,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _deleteIcon(dynamic deletedImageData) {
    return Positioned(
      top: 2,
      right: 0,
      child: GestureDetector(
        onTap: () => onDeleteImageClick?.call(deletedImageData),
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.blackNormal,
            border: Border.all(width: 1, color: AppColors.grayLight),
          ),
          child: Center(
            child: Assets.images.svg.closeCircle.svg(
              width: 5.75,
              height: 5.75,
            ),
          ),
        ),
      ),
    );
  }
}
