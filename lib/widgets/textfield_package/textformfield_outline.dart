import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../gen/assets.gen.dart';
import '../../resources/resources.dart';

class TextFormFieldOutline extends StatefulWidget {
  final String? hintText;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isObscureEnable;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  TextFormFieldOutline({
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.keyboardType,
    this.inputFormatters,
    this.isObscureEnable = false,
    this.onChanged,
    this.validator,
  });

  @override
  State<TextFormFieldOutline> createState() => _TextFormFieldOutlineState();
}

class _TextFormFieldOutlineState extends State<TextFormFieldOutline> {
  bool _isObscure = false;
  @override
  void initState() {
    if (widget.isObscureEnable) {
      _isObscure = true;
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      obscureText: _isObscure,
      validator: widget.validator,
      cursorColor: AppColors.mediumBlue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType,
      inputFormatters: [],
      style: TextStyle(
        color: AppColors.mediumBlue,
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: AppColors.mediumBlue),
        focusColor: AppColors.mediumBlue,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.mediumBlue),
        ),
        labelText: widget.hintText,
        prefixIcon: Icon(
          widget.prefixIconData,
          size: 18,
          color: AppColors.mediumBlue,
        ),
        suffixIcon: widget.isObscureEnable
            ? _buildObscureIcon()
            : GestureDetector(
                onTap: () {
                  // model.isVisible = !model.isVisible;
                },
                child: Icon(
                  widget.suffixIconData,
                  size: 18,
                  color: AppColors.mediumBlue,
                ),
              ),
      ),
    );
  }

  // Toggles show
  void _toggle() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Widget _buildObscureIcon() {
    return _buildSuffixIcon(
      svgGenImage:
          _isObscure ? Assets.images.svg.eyeSlash : Assets.images.svg.eye,
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
            color: AppColors.grayNormal,
          ),
        ),
      ),
    );
  }
}
