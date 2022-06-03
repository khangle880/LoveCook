import 'package:flutter/material.dart';

class TextStyleExtConfig {
  final int? maxLines;
  final double? textScaleFactor;
  final TextOverflow? overflow;
  final bool? softWrap;
  final Locale? locale;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final StrutStyle? strutStyle;

  const TextStyleExtConfig(
      {this.maxLines,
      this.textScaleFactor,
      this.overflow,
      this.softWrap,
      this.locale,
      this.textDirection,
      this.textAlign,
      this.strutStyle});
}

class TextExtCustomize extends StatelessWidget {
  const TextExtCustomize(
    this.data, {
    this.config,
    this.style,
    Key? key,
  }) : super(key: key);

  final TextStyleExtConfig? config;
  final String data;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: config?.maxLines,
      overflow: config?.overflow,
      textScaleFactor: config?.textScaleFactor,
      softWrap: config?.softWrap,
      locale: config?.locale,
      textDirection: config?.textDirection,
      textAlign: config?.textAlign,
      strutStyle: config?.strutStyle,
      style: style,
    );
  }
}
