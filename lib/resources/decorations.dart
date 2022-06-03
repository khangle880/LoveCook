import 'package:flutter/material.dart';

class Decorations {
  static BoxShadow commonShadow({
    Color? color,
    double? blurRadius,
    Offset? offset,
  }) {
    return BoxShadow(
      color: color ?? Color.fromRGBO(30, 3, 13, 0.3),
      blurRadius: blurRadius ?? 8,
      offset: offset ?? Offset(0, 4),
    );
  }
}
