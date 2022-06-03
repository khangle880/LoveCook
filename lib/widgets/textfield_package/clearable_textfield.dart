import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import 'textfield_package.dart';

class ClearableTextField extends StatefulWidget {
  const ClearableTextField(
      {Key? key,
      required this.hintText,
      required this.labelText,
      this.style,
      this.helperText,
      this.isEnabled = true,
      this.isForm = false,
      this.maxLine = 20,
      this.controller,
      this.validator,
      this.cursorColor,
      this.decoration})
      : super(key: key);
  final String hintText;
  final String labelText;
  final bool isEnabled;
  final bool isForm;
  final int maxLine;
  final TextEditingController? controller;
  final TextStyle? style;
  final String? helperText;
  final Color? cursorColor;
  final Validate? Function(String? value)? validator;
  final InputDecoration? decoration;

  @override
  State<ClearableTextField> createState() => _ClearableTextFieldState();
}

class _ClearableTextFieldState extends State<ClearableTextField> {
  bool _isEmptyText = true;

  late TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _isEmptyText = _controller.text.isEmpty;
    _controller.addListener(() {
      if (_controller.text.isEmpty != _isEmptyText) {
        _isEmptyText = _controller.text.isEmpty;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isForm
        ? GuideTextFormField(
            cursorColor: widget.cursorColor,
            maxLine: widget.maxLine,
            hintText: widget.hintText,
            labelText: widget.labelText,
            isEnabled: widget.isEnabled,
            controller: _controller,
            helperText: widget.helperText,
            validator: widget.validator,
            suffixIcon: _isEmptyText ? null : Assets.images.svg.closeCircle,
            onPressedSuffix: (controller) => controller.text = "",
            decoration: widget.decoration,
          )
        : GuideTextField(
            hintText: widget.hintText,
            labelText: widget.labelText,
            isEnabled: widget.isEnabled,
            controller: _controller,
            helperText: widget.helperText,
            validator: widget.validator,
            suffixIcon: _isEmptyText ? null : Assets.images.svg.closeCircle,
            onPressedSuffix: (controller) => controller.text = "",
          );
  }
}
