import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/resources.dart';

class Blur extends StatelessWidget {
  Blur({
    Key? key,
    required this.child,
    this.blur = 5,
    this.blurColor = Colors.white,
    this.borderRadius,
    this.colorOpacity = 0.5,
    this.decoration,
    this.overlay,
    this.blurSize,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final Widget child;
  final double blur;
  final Color blurColor;
  final BorderRadius? borderRadius;
  final BoxDecoration? decoration;
  final double colorOpacity;
  final double? blurSize;
  final Widget? overlay;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Stack(
        children: [
          child,
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              height: blurSize,
              decoration:
                  decoration ?? BoxDecoration(gradient: AppColors.blurLayer),
              alignment: alignment,
              child: overlay,
            ),
          ),
        ],
      ),
    );
  }
}
