import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../gen/assets.gen.dart';
import '../../resources/resources.dart';

class CustomIconButton extends StatelessWidget {
  final double size;
  final bool disable;
  final Widget icon;
  final VoidCallback? onTap;

  const CustomIconButton({
    Key? key,
    this.disable = false,
    required this.icon,
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
          color: Color(0xFFC2DED1),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
}
