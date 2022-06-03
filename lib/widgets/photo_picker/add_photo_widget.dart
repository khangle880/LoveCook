import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../gen/assets.gen.dart';
import '../../resources/resources.dart';

class AddPhotoButtonWidget extends StatelessWidget {
  final int progress;
  final int max;
  final double size;
  final bool disable;
  final VoidCallback? onTap;

  const AddPhotoButtonWidget({
    Key? key,
    required this.progress,
    required this.max,
    this.disable = false,
    this.size = 44,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.grayLight.withOpacity(0.4),
        ),
        child: Column(
          children: [
            Expanded(
              child: Assets.images.svg.icPickPhoto.svg(color: AppColors.whiteLight),
            ),
            '$progress/$max'.s10w500(
              color: AppColors.whiteLight,
            ),
          ],
        ),
      ),
    );
  }
}
