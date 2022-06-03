import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../gen/assets.gen.dart';
import '../../resources/resources.dart';
import 'guide_textfield.dart';

class GuideTextFormField extends StatefulWidget {
  final int maxLine;
  final String hintText;
  final String? helperText;
  final String labelText;
  final Color? labelColor;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? cursorColor;
  final bool isEnabled;
  final bool isObscure;
  final SvgGenImage? suffixIcon;
  final Widget? suffixWidget;
  final void Function(TextEditingController controller)? onPressedSuffix;
  final bool readOnly;
  final OutlineInputBorder? enableBorder;
  final TextEditingController? controller;
  final Validate? Function(String? value)? validator;
  final bool? validateAtInit;
  final InputDecoration? decoration;

  const GuideTextFormField(
      {Key? key,
      required this.hintText,
      required this.labelText,
      this.maxLine = 20,
      this.controller,
      this.helperText,
      this.validator,
      this.isObscure = false,
      this.isEnabled = true,
      this.suffixIcon,
      this.onPressedSuffix,
      this.readOnly = false,
      this.enableBorder,
      this.validateAtInit = false,
      this.suffixWidget,
      this.labelColor,
      this.backgroundColor,
      this.textColor,
      this.decoration,
      this.cursorColor})
      : super(key: key);

  @override
  State<GuideTextFormField> createState() => _GuideTextFormFieldState();
}

class _GuideTextFormFieldState extends State<GuideTextFormField> {
  late bool _obscureText;
  Validate? _validate;
  late TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _obscureText = widget.isObscure;
    _controller = widget.controller ?? TextEditingController();
    if (widget.validateAtInit ?? false) {
      _validate = widget.validator
          ?.call(_controller.text.isEmpty ? null : _controller.text);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  // Validate Text
  void _handleValidate() {
    _validate = widget.validator?.call(_controller.text);
    setState(() {});
  }

  // Toggles show
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.whiteLight));
    final OutlineInputBorder border = widget.enableBorder ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: _validate?.isValid ?? true
                ? AppColors.grayNormal
                : AppColors.errorNormal,
          ),
        );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText.isNotEmpty) ...[
          widget.labelText.s16w400(
            color: widget.labelColor != null
                ? widget.labelColor
                : widget.isEnabled
                    ? AppColors.primaryWhite
                    : AppColors.grayNormal,
            style: TextStyle(letterSpacing: 0.15),
          ),
          SizedBox(height: 4),
        ],
        Container(
          height: 70,
          child: TextFormField(
            controller: _controller,
            cursorColor: widget.cursorColor,
            maxLength: widget.maxLine,
            obscureText: _obscureText,
            enabled: widget.isEnabled ? !widget.readOnly : false,
            style: ''.s16w400style(
              color: widget.textColor != null
                  ? widget.textColor
                  : widget.isEnabled
                      ? AppColors.whiteNormal
                      : AppColors.grayNormal,
            ),
            onChanged: (_) {
              _handleValidate();
            },
            decoration: InputDecoration(
                counterStyle: ''.s12w400style(color: AppColors.whiteLight),
                suffixIconConstraints: BoxConstraints(maxWidth: 24),
                suffixIcon: widget.isObscure
                    ? _buildObscureIcon()
                    : widget.suffixWidget != null
                        ? _buildSuffixWidget(
                            widget: widget.suffixWidget ?? SizedBox(),
                            onTap: () {
                              if (widget.onPressedSuffix == null) return;
                              widget.onPressedSuffix!.call(_controller);
                              _handleValidate();
                            })
                        : widget.suffixIcon != null
                            ? _buildSuffixIcon(
                                svgGenImage: widget.suffixIcon!,
                                onTap: () {
                                  if (widget.onPressedSuffix == null) return;
                                  widget.onPressedSuffix!.call(_controller);
                                  _handleValidate();
                                })
                            : null,
                focusColor: AppColors.whiteLight,
                focusedBorder: defaultBorder,
                enabledBorder: defaultBorder,
                border: defaultBorder),
          ),
        ),
        SizedBox(height: 4),
        if (_validate == null && widget.helperText != null)
          widget.helperText!.s12w600(color: AppColors.grayNormal)
        else if (_validate != null)
          _validate!.output.s12w600(
            color: _validate!.isValid
                ? AppColors.successDarken
                : AppColors.errorNormal,
          ),
      ],
    );
  }

  Widget _buildObscureIcon() {
    return _buildSuffixIcon(
      svgGenImage:
          _obscureText ? Assets.images.svg.eyeSlash : Assets.images.svg.eye,
      onTap: _toggle,
    );
  }

  Widget _buildSuffixIcon(
      {required SvgGenImage svgGenImage, required void Function() onTap}) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        splashRadius: 30 / 2,
        onPressed: onTap,
        icon: Container(
          height: 24,
          width: 24,
          child: svgGenImage.svg(
            height: 24,
            width: 24,
            color: widget.isEnabled ? null : AppColors.grayNormal,
          ),
        ),
      ),
    );
  }

  Widget _buildSuffixWidget(
      {required Widget widget, required void Function() onTap}) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        splashRadius: 30 / 2,
        onPressed: onTap,
        icon: Container(
          alignment: Alignment(1, 0.0),
          height: 24,
          child: widget,
        ),
      ),
    );
  }
}
