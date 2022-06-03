import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../gen/assets.gen.dart';
import '../widgets.dart';
import 'guide_textfield.dart';

class DatePickerTextField extends StatefulWidget {
  const DatePickerTextField({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.datePickerHelpText,
    this.helperText,
    this.isEnabled = true,
    this.controller,
    this.validator,
  }) : super(key: key);
  final String hintText;
  final String labelText;
  final bool isEnabled;
  final String? datePickerHelpText;
  final TextEditingController? controller;
  final String? helperText;
  final Validate? Function(String? value)? validator;

  @override
  State<DatePickerTextField> createState() => _TextFieldDatePickerState();
}

class _TextFieldDatePickerState extends State<DatePickerTextField> {
  @override
  Widget build(BuildContext context) {
    return GuideTextField(
      hintText: widget.hintText,
      labelText: widget.labelText,
      isEnabled: widget.isEnabled,
      controller: widget.controller,
      helperText: widget.helperText,
      validator: widget.validator,
      suffixIcon: Assets.images.svg.calendarOutline,
      onPressedSuffix: (controller) {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
          helpText: widget.datePickerHelpText, // Can be used as title
          confirmText: 'Done',
        ).then((value) {
          if (value != null) {
            controller.text = DateFormat('dd-MM-yyyy').format(value);
          }
        });
      },
    );
  }
}
