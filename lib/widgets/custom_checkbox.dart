import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../gen/assets.gen.dart';
import '../resources/resources.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    Key? key,
    this.label,
    this.onChanged,
    this.spaceBetween = 12,
    this.enable = true,
    this.value = false,
    this.textStyle,
    this.uncheckedColor,
    this.checkedColor,
  }) : super(key: key);

  final TextStyle? textStyle;
  final String? label;
  final double? spaceBetween;
  final bool value;
  final bool enable;
  final ValueChanged<bool>? onChanged;
  final Color? uncheckedColor;
  final Color? checkedColor;

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.value;
  }

  @override
  void didUpdateWidget(covariant CustomCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isSelected != widget.value) {
      _isSelected = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      child: GestureDetector(
        onTap: () {
          _updateState();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 24,
              height: 24,
              child: _isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.checkedColor ?? AppColors.primaryNormal,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Assets.images.svg.icTick
                              .svg(color: AppColors.primaryWhite),
                        ),
                      ),
                    )
                  : Assets.images.svg.icCheckboxUnchecked
                      .svg(color: widget.uncheckedColor ?? AppColors.grayLight),
            ),
            if (widget.label != null) ...[
              SizedBox(
                width: widget.spaceBetween,
              ),
              Text(
                widget.label ?? '',
                style: widget.textStyle ?? ''.s14w600style(),
              ),
            ]
          ],
        ),
      ),
    );
  }

  void _updateState() {
    if (widget.enable) {
      setState(() {
        _isSelected = !_isSelected;
        widget.onChanged?.call(_isSelected);
      });
    }
  }
}
