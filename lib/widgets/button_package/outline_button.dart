import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../extensions/extensions.dart';
import '../../resources/resources.dart';

/// Expand full width
/// You can't change width if [expand] set to true
/// You have to use Margin to make button smaller
/// ```dart
/// OutlineViiButton(
///   buttonSize = ButtonSize.medium
///   margin: EdgeInsets.symmetric(horizontal: 16),
///   expand: true,
///   text: "Login"
/// )
/// ```
///
/// Custom width which [expand] set to false
/// ```dart
/// OutlineViiButton(
///   width: 50
///   height: 50
///   margin: EdgeInsets.symmetric(horizontal: 16),
///   expand: true,
///   onPressed: () {},
///   text: "Login"
/// )
/// ```
///
/// Custom Contentbuilder [currentColor] with base on onTapDown and onTapCancle events
/// ```dart
/// OutlineViiButton(
///   expand: true,
///   contentBuilder: (currentColor) {
///     return Stack(
///       children: [
///         Align(
///             alignment: Alignment(-0.9, 0.0),
///             child: icon.svg(width: 28, height: 28)),
///         Align(alignment: Alignment.center, child: title)
///       ],
///     );
///   },
/// )

class OutlineButton extends StatefulWidget {
  const OutlineButton({
    Key? key,
    this.text,
    this.contentBuilder,
    this.boderColor = AppColors.borderLight,
    this.defaultColor = AppColors.blackLight,
    this.hightLightColor = const Color(0xFFF6E3C5),
    this.color = Colors.transparent,
    this.splashColor = const Color(0xFFF6E3C5),
    this.disableColor = AppColors.grayNormal,
    this.width,
    this.height,
    this.borderRadius = 12.0,
    this.disable = false,
    this.expand = false,
    this.buttonSize = ButtonSize.large,
    this.padding = const EdgeInsets.only(),
    this.margin = const EdgeInsets.only(),
    required this.onPressed,
  })  : assert(text != null || contentBuilder != null),
        super(key: key);

  final double? width;
  final double? height;
  final double borderRadius;
  final String? text;
  final Widget Function(Color currentColor)? contentBuilder;
  final Color color;
  final Color boderColor;
  final Color defaultColor;
  final Color hightLightColor;
  final Color splashColor;
  final Color disableColor;
  final bool expand;
  final bool disable;
  final ButtonSize buttonSize;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final VoidCallback? onPressed;

  @override
  _OutlineButtonState createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  late Color currentBorderColor =
      !widget.disable ? widget.boderColor : widget.disableColor;
  late Color currentColor =
      !widget.disable ? widget.defaultColor : widget.disableColor;

  @override
  Widget build(BuildContext context) {
    return widget.expand
        ? _buildButton()
        : UnconstrainedBox(
            child: _buildButton(),
          );
  }

  Widget _buildButton() {
    double? width = widget.width;
    double? height = widget.height;
    TextStyle? textStyle;

    if (height == null) {
      switch (widget.buttonSize) {
        case ButtonSize.large:
          height = 44;
          textStyle = ''.s16w600style(color: currentColor);
          break;
        case ButtonSize.medium:
          height = 36;
          textStyle = ''.s14w600style(color: currentColor);
          break;
        case ButtonSize.small:
          height = 32;
          textStyle = ''.s14w600style(color: currentColor);
          break;
      }
    } else {
      textStyle = ''.s14w600style(color: currentColor);
    }

    return GestureDetector(
      onTapCancel: () {
        setState(() {
          if (!widget.disable) {
            currentColor = widget.defaultColor;
            currentBorderColor = widget.boderColor;
          }
        });
      },
      onTapDown: (detail) {
        setState(() {
          if (!widget.disable) {
            currentColor = widget.hightLightColor;
            currentBorderColor = widget.hightLightColor;
          }
        });
      },
      child: Container(
        padding: widget.padding,
        margin: widget.margin,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
              color: !widget.disable ? currentBorderColor : widget.disableColor,
              width: 1.0),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            splashColor: widget.splashColor,
            onTap: !widget.disable ? widget.onPressed : null,
            child: Center(
              child: widget.text != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.text!,
                        style: textStyle,
                      ),
                    )
                  : widget.contentBuilder!.call(currentColor),
            ),
          ),
        ),
      ),
    );
  }
}
