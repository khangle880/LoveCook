import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/textfield_package/text_ext_customize.dart';

class TextStyleExtensionPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            'Lexend Medium 20pt (s20w500)'.s20w500(),
            'Lexend Semibold 18pt (s18w600)'.s18w600(),
            'Lexend Semibold 16pt (s16w600)'.s16w600(
                style: TextStyle(overflow: TextOverflow.ellipsis),
                config: TextStyleExtConfig(maxLines: 2)),
            'Lexend SemiBold 14pt (s14w600)'.s14w600(),
            'Lexend Semibold 12pt (s12w600)'.s12w600(),
            'Lexend Regular 16pt (s16w400)'.s16w400(),
            'Lexend Regular 15pt (s15w400)'.s15w400(),
            'Lexend Regular 13pt (s13w400)'.s13w400(),
            'Lexend Semibold 15pt (s15w500)'.s15w500(),
            'Lexend Semibold 13pt (s13w600)'.s13w600(),
            'Lexend Medium 14pt (s14w500)'.s14w500(),
            'Lexend Semibold 12pt (s12w400)'.s12w400(),
            'Lexend Semibold 10pt (s10w600)'.s10w600(),
            'Lexend Medium 10pt (s10w500)'.s10w500(),
            RichText(
                text: 'Quoc'.s20w500span(color: Colors.red, child: [
              'Huynh'.s12w400span(color: Colors.yellow),
              'Lecle'.s10w500span(color: Colors.greenAccent),
            ]))
          ],
        ),
      ),
    );
  }
}

extension TextStyleExtensions on String {
  /// Regex text span
  TextSpan regTextSpan({
    TextStyle? style,
    Map<RegExp, TextStyle>? patternMatchMap,
    Map<String, TextStyle>? stringMatchMap,
    required Function(List<String> match) onMatch,
  }) {
    List<TextSpan> children = [];
    List<String> matches = [];

    // Validating with REGEX
    RegExp? allRegex;
    allRegex = patternMatchMap != null
        ? RegExp(patternMatchMap.keys.map((e) => e.pattern).join('|'))
        : null;
    // Validating with Strings
    RegExp? stringRegex;
    stringRegex = stringMatchMap != null
        ? RegExp(r'\b' + stringMatchMap.keys.join('|').toString() + r'+\b')
        : null;
    ////
    this.splitMapJoin(
      stringMatchMap == null ? allRegex! : stringRegex!,
      onNonMatch: (String span) {
        children.add(TextSpan(text: span, style: style));
        return span.toString();
      },
      onMatch: (Match m) {
        if (!matches.contains(m[0])) matches.add(m[0]!);
        final RegExp? k = patternMatchMap?.entries.firstWhere((element) {
          return element.key.allMatches(m[0]!).isNotEmpty;
        }).key;
        final String? ks = stringMatchMap?.entries.firstWhere((element) {
          return element.key.allMatches(m[0]!).isNotEmpty;
        }).key;

        children.add(
          TextSpan(
            text: m[0],
            style: stringMatchMap == null
                ? patternMatchMap![k]
                : stringMatchMap[ks],
          ),
        );

        return (onMatch(matches) ?? '');
      },
    );
    return TextSpan(style: style, children: children);
  }

  TextExtCustomize s62w700(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s62w700style(color: color, style: style),
    );
  }

  TextSpan s62w700span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s62w700style(color: color, style: style),
    );
  }

  TextStyle? s62w700style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 62,
            fontWeight: FontWeight.w700,
            color: color,
            height: 28 / 20)
        .merge(style);
  }

  ///
  TextExtCustomize s50w700(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s50w700style(color: color, style: style),
    );
  }

  TextSpan s50w700span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s50w700style(color: color, style: style),
    );
  }

  TextStyle? s50w700style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 50,
            fontWeight: FontWeight.w700,
            color: color,
            height: 28 / 20)
        .merge(style);
  }

  ///
  TextExtCustomize s24w700(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s24w700style(color: color, style: style),
    );
  }

  TextSpan s24w700span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s24w700style(color: color, style: style),
    );
  }

  TextStyle? s24w700style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: color,
            height: 28 / 20)
        .merge(style);
  }

  ///
  TextExtCustomize s20w700(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s20w700style(color: color, style: style),
    );
  }

  TextSpan s20w700span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s20w700style(color: color, style: style),
    );
  }

  TextStyle? s20w700style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: color,
            height: 28 / 20)
        .merge(style);
  }

  // TextStyle? s20w700TitleStyle({Color? color, TextStyle? style}) {
  //   return GoogleFonts.a;
  // }

  /// Heading 1
  TextExtCustomize s20w600(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s20w600style(color: color, style: style),
    );
  }

  TextSpan s20w600span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s20w600style(color: color, style: style),
    );
  }

  TextStyle? s20w600style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: color,
            height: 28 / 20)
        .merge(style);
  }

  ///
  TextExtCustomize s20w500(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s20w500style(color: color, style: style),
    );
  }

  TextSpan s20w500span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s20w500style(color: color, style: style),
    );
  }

  TextStyle? s20w500style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: color,
            height: 28 / 20)
        .merge(style);
  }

  ///
  TextExtCustomize s18w700(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s18w700style(color: color, style: style),
    );
  }

  TextSpan s18w700span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s18w700style(color: color, style: style),
    );
  }

  TextStyle? s18w700style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: color,
            height: 28 / 18)
        .merge(style);
  }

  /// Heading 2.
  TextExtCustomize s18w600(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s18w600style(color: color, style: style),
    );
  }

  TextSpan s18w600span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s18w600style(color: color, style: style),
    );
  }

  TextStyle? s18w600style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color,
            height: 28 / 18)
        .merge(style);
  }

  ///
  TextExtCustomize s16w700(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s16w700style(color: color, style: style),
    );
  }

  TextSpan s16w700span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s16w700style(color: color, style: style),
    );
  }

  TextStyle? s16w700style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: color,
            height: 24 / 16)
        .merge(style);
  }

  /// Button 1
  TextExtCustomize s16w600(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s16w600style(color: color, style: style),
    );
  }

  TextSpan s16w600span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s16w600style(color: color, style: style),
    );
  }

  TextStyle? s16w600style({Color? color, TextStyle? style}) {
    return TextStyle(
            fontSize: 16,
            fontFamily: 'Aharoni',
            fontWeight: FontWeight.w600,
            color: color,
            height: 24 / 16)
        .merge(style);
  }

  TextExtCustomize s15w700(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s15w700style(color: color, style: style),
    );
  }

  TextSpan s15w700span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s15w700style(color: color, style: style),
    );
  }

  TextStyle? s15w700style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: color,
            height: 24 / 16)
        .merge(style);
  }

  TextExtCustomize s14w700(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s14w700style(color: color, style: style),
    );
  }

  TextSpan s14w700span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s14w700style(color: color, style: style),
    );
  }

  TextStyle? s14w700style({Color? color, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'Aharoni',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: color,
            height: 20 / 14)
        .merge(style);
  }

  /// Button 2
  TextExtCustomize s14w600(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s14w600style(color: color, style: style),
    );
  }

  TextSpan s14w600span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s14w600style(color: color, style: style),
    );
  }

    TextStyle? s14w400style({Color? color, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'Aharoni',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
            height: 20 / 14)
        .merge(style);
  }

  TextStyle? s14w600style({Color? color, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'Aharoni',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
            height: 20 / 14)
        .merge(style);
  }

  /// Button 3
  TextExtCustomize s12w600(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s12w600style(color: color, style: style),
    );
  }

  TextSpan s12w600span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s12w600style(color: color, style: style),
    );
  }

  TextStyle? s12w600style({Color? color, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'Aharoni',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
            height: 16 / 12)
        .merge(style);
  }

  /// Paragraph 1
  TextExtCustomize s16w400(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s16w400style(color: color, style: style),
    );
  }

  TextSpan s16w400span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: s16w400style(color: color, style: style),
    );
  }

  TextStyle? s16w400style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: color,
            height: 22 / 16)
        .merge(style);
  }

  /// Paragraph 2
  TextExtCustomize s15w400(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s15w400style(color: color, style: style),
    );
  }

  TextSpan s15w400span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      recognizer: recognizer,
      children: child,
      style: s15w400style(color: color, style: style),
    );
  }

  TextStyle? s15w400style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: color,
            height: 20 / 15)
        .merge(style);
  }

  TextExtCustomize s13w700(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s13w700style(color: color, style: style),
    );
  }

  TextSpan s13w700span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      recognizer: recognizer,
      children: child,
      style: s13w700style(color: color, style: style),
    );
  }

  TextStyle? s13w700style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: color,
            height: 18 / 13)
        .merge(style);
  }

  /// Paragraph 3
  TextExtCustomize s13w400(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s13w400style(color: color, style: style),
    );
  }

  TextSpan s13w400span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      recognizer: recognizer,
      children: child,
      style: s13w400style(color: color, style: style),
    );
  }

  TextStyle? s13w400style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: color,
            height: 18 / 13)
        .merge(style);
  }

  /// subtitle 2
  TextExtCustomize s15w500(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s15w500style(color: color, style: style),
    );
  }

  TextSpan s15w500span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      recognizer: recognizer,
      children: child,
      style: s15w500style(color: color, style: style),
    );
  }

  TextStyle? s15w500style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: color,
            height: 20 / 15)
        .merge(style);
  }

  /// subtitle 3
  TextExtCustomize s13w600(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s13w600style(color: color, style: style),
    );
  }

  TextSpan s13w600span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      recognizer: recognizer,
      children: child,
      style: s13w600style(color: color, style: style),
    );
  }

  TextStyle? s13w600style({Color? color, TextStyle? style}) {
    return GoogleFonts.lexendDeca(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
            height: 18 / 13)
        .merge(style);
  }

  /// Label 1
  TextExtCustomize s14w500(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s14w500style(color: color, style: style),
    );
  }

  TextSpan s14w500span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      recognizer: recognizer,
      children: child,
      style: s14w500style(color: color, style: style),
    );
  }

  TextStyle? s14w500style({Color? color, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'Calibri',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color,
            height: 20 / 14)
        .merge(style);
  }

  /// Label 3
  TextExtCustomize s12w700(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s12w700style(color: color, style: style),
    );
  }

  TextSpan s12w700span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      recognizer: recognizer,
      children: child,
      style: s12w700style(color: color, style: style),
    );
  }

  TextStyle? s12w700style({Color? color, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'Calibri',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: color,
            height: 16 / 12)
        .merge(style);
  }

  /// Label 3
  TextExtCustomize s12w400(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s12w400style(color: color, style: style),
    );
  }

  TextSpan s12w400span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      recognizer: recognizer,
      children: child,
      style: s12w400style(color: color, style: style),
    );
  }

  TextStyle? s12w400style({Color? color, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'Calibri',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
            height: 16 / 12)
        .merge(style);
  }

  /// Label 4
  TextExtCustomize s10w600(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s10w600style(color: color, style: style),
    );
  }

  TextSpan s10w600span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      recognizer: recognizer,
      children: child,
      style: s10w600style(color: color, style: style),
    );
  }

  TextStyle? s10w600style({Color? color, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'Calibri',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color,
            height: 14 / 10)
        .merge(style);
  }

  /// Label 4
  TextExtCustomize s10w500(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s10w500style(color: color, style: style),
    );
  }

  TextExtCustomize s10w400(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s10w400style(color: color, style: style),
    );
  }

  TextSpan s10w500span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      recognizer: recognizer,
      children: child,
      style: s10w500style(color: color, style: style),
    );
  }

  TextStyle? s10w500style({Color? color, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'Calibri',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: color,
            height: 14 / 10)
        .merge(style);
  }

  TextStyle? s10w400style({Color? color, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'Calibri',
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: color,
            height: 14 / 10)
        .merge(style);
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  TextExtCustomize s13w500(
      {Color? color, TextStyle? style, TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: s13w500style(color: color, style: style),
    );
  }

  TextSpan s13w500span(
      {Color? color,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      recognizer: recognizer,
      children: child,
      style: s13w500style(color: color, style: style),
    );
  }

  TextStyle? s13w500style({Color? color, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'Calibri',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: color,
            height: 18 / 13)
        .merge(style);
  }
}
