import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({
    Key? key,
    this.hintText,
    this.lableText,
    this.onChanged,
    this.validator,
    this.maxLine,
    this.initValue,
    this.keyboardType,
  }) : super(key: key);

  final String? initValue;
  final String? hintText;
  final String? lableText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLine;
  final TextInputType? keyboardType;

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
        labelText: lableText,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: AppColors.grayNormal),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
