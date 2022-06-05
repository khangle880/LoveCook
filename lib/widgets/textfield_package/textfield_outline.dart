import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/resources.dart';

class TextFieldOutline extends StatelessWidget {
  final String? hintText;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final Function(String)? onChanged;

  TextFieldOutline({
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<TextFieldModel>(context);

    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      cursorColor: AppColors.mediumBlue,
      keyboardType: keyboardType,
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
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: AppColors.mediumBlue,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            // model.isVisible = !model.isVisible;
          },
          child: Icon(
            suffixIconData,
            size: 18,
            color: AppColors.mediumBlue,
          ),
        ),
      ),
    );
  }
}
