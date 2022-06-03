import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../resources/resources.dart';
import '../../resources/colors.dart';

class MaterialInkwellButton extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final BoxConstraints? constraints;
  final VoidCallback? onTap;

  MaterialInkwellButton(
      {required this.title,
      required this.hasBorder,
      this.constraints,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? AppColors.white : AppColors.mediumBlue,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder
              ? Border.all(
                  color: AppColors.mediumBlue,
                  width: 1.0,
                )
              : Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            constraints: constraints,
            height: 60.0,
            child: Center(
              child: AutoSizeText(
                title,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: hasBorder ? AppColors.mediumBlue : AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
