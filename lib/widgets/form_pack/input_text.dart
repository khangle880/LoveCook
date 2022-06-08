import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget(
      {Key? key,
      this.hintText,
      this.lableText,
      this.onChanged,
      this.validator,
      this.maxLine,
      this.initValue,
      this.keyboardType,
      this.hintTextColor,
      this.backgroundColor})
      : super(key: key);

  final String? initValue;
  final String? hintText;
  final String? lableText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLine;
  final TextInputType? keyboardType;
  final Color? hintTextColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      initialValue: initValue,
      style: TextStyle(fontSize: 14),
      onChanged: onChanged,
      validator: validator ??
          (value) {
            if ((value ?? '').isEmpty) return 'Value Can\'t Be Empty';
            return null;
          },
      maxLines: maxLine,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        fillColor: backgroundColor ?? Colors.white,
        filled: true,
        labelText: lableText,
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 14, color: hintTextColor ?? AppColors.grayNormal),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
