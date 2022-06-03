import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../gen/assets.gen.dart';
import '../resources/resources.dart';

class CustomRadioTitle<T> extends StatefulWidget {
  const CustomRadioTitle({
    Key? key,
    this.label,
    this.onChanged,
    this.spaceBetween = 12,
    this.enable = true,
    required this.value,
    this.groupValue,
    this.textStyle,
    this.uncheckedColor,
    this.checkedColor,
  }) : super(key: key);

  final TextStyle? textStyle;
  final String? label;
  final double? spaceBetween;
  final T value;
  final T? groupValue;
  final bool enable;
  final ValueChanged<T>? onChanged;
  final Color? uncheckedColor;
  final Color? checkedColor;

  @override
  _CustomRadioTitleState<T> createState() => _CustomRadioTitleState<T>();
}

class _CustomRadioTitleState<T> extends State<CustomRadioTitle<T>> {
  T? _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.groupValue;
  }

  @override
  void didUpdateWidget(covariant CustomRadioTitle<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_groupValue != widget.groupValue) {
      _groupValue = widget.groupValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              _updateState();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 24,
                  height: 24,
                  child: widget.value == _groupValue
                      ? Assets.images.svg.icRadioChecked.svg(
                          color: widget.checkedColor ?? AppColors.primaryNormal)
                      : Assets.images.svg.icRadioUncheck.svg(
                          color: widget.uncheckedColor ?? AppColors.whiteDarken),
                ),
                if (widget.label != null) ...[
                  SizedBox(
                    width: widget.spaceBetween,
                  ),
                  Text(
                    widget.label ?? '',
                    style: widget.textStyle ?? ''.s16w400style(color: AppColors.primaryWhite),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateState() {
    if (widget.enable) {
      setState(() {
        _groupValue = widget.value;
        widget.onChanged?.call(widget.value);
      });
    }
  }
}
