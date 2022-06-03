import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../resources/resources.dart';
import '../../extensions/extensions.dart';

/// Expand full width
/// You can't change width if [expand] set to true
/// You have to use Margin to make button smaller
/// ```dart
/// FilledViiButton(
///   buttonSize = ButtonSize.medium
///   margin: EdgeInsets.symmetric(horizontal: 16),
///   expand: true,
///   text: "Login"
/// )
/// ```
///
/// Custom width which [expand] set to false
/// ```dart
/// FilledViiButton(
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
/// FilledViiButton(
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

class FilledViiButton extends StatefulWidget {
  const FilledViiButton({
    Key? key,
    this.text,
    this.contentBuilder,
    this.defaultColor = AppColors.blackDarken,
    this.hightLightColor = AppColors.secondaryNormal,
    this.splashColor = AppColors.primaryDarken,
    this.disableColor = AppColors.blackNormal,
    this.disableChildColor = AppColors.grayDarken,
    this.backgroundColor = AppColors.primaryNormal,
    this.width,
    this.height,
    this.borderRadius = 12.0,
    this.disable = false,
    this.expand = false,
    this.buttonSize = ButtonSize.large,
    this.padding = const EdgeInsets.only(),
    this.margin = const EdgeInsets.only(),
    this.onPressed,
  })  : assert(text != null || contentBuilder != null),
        super(key: key);

  final double? width;
  final double? height;
  final double borderRadius;
  final String? text;
  final Widget Function(Color currentColor)? contentBuilder;
  final Color defaultColor;
  final Color hightLightColor;
  final Color backgroundColor;
  final Color splashColor;
  final Color disableColor;
  final Color disableChildColor;
  final bool expand;
  final bool disable;
  final ButtonSize buttonSize;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final VoidCallback? onPressed;

  @override
  _FilledViiButtonState createState() => _FilledViiButtonState();
}

class _FilledViiButtonState extends State<FilledViiButton> {
  late Color currentChildColor =
      widget.disable ? widget.disableChildColor : widget.defaultColor;

  @override
  Widget build(BuildContext context) {
    return widget.expand
        ? _buildButton()
        : UnconstrainedBox(
            child: _buildButton(),
          );
  }

 @override
  void didUpdateWidget(covariant FilledViiButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentChildColor =
        widget.disable ? widget.disableChildColor : widget.defaultColor;
  }

  Widget _buildButton() {
    double? width = widget.width;
    double? height = widget.height;
    TextStyle? textStyle = ''.s14w600style(color: currentChildColor);

    if (height == null) {
      switch (widget.buttonSize) {
        case ButtonSize.large:
          height = 44;
          textStyle = ''.s16w600style(color: currentChildColor);
          break;
        case ButtonSize.medium:
          height = 36;
          textStyle = ''.s14w600style(color: currentChildColor);
          break;
        case ButtonSize.small:
          height = 32;
          textStyle = ''.s14w600style(color: currentChildColor);
          break;
      }
    }

    return GestureDetector(
      onTapCancel: () {
        setState(() {
          if (!widget.disable) {
            currentChildColor = widget.defaultColor;
          }
        });
      },
      onTapDown: (detail) {
        setState(() {
          if (!widget.disable) {
            currentChildColor = widget.hightLightColor;
          }
        });
      },
      child: Container(
        padding: widget.padding,
        margin: widget.margin,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: !widget.disable ? widget.backgroundColor : widget.disableColor,
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
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        widget.text!,
                        style: textStyle,
                      ),
                    )
                  : widget.contentBuilder!.call(currentChildColor),
            ),
          ),
        ),
      ),
    );
  }
}
