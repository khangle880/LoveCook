import 'dart:async';

import 'package:flutter/material.dart';

import '../../../extensions/extensions.dart';
import '../../../resources/resources.dart';
import '../../gen/assets.gen.dart';
import 'guide_textfield.dart';

class DateTextField extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? labelText;
  final ValueChanged<DateTime>? onDateChanged;
  // passing this attribute to control close picker when action from outside
  final Stream<bool>? hidePickerStream;
  const DateTextField({
    Key? key,
    required this.initialDate,
    this.labelText,
    this.onDateChanged,
    this.firstDate,
    this.lastDate,
    this.hidePickerStream,
  }) : super(key: key);

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  late TextEditingController _textEditingController;
  late LayerLink _layerLink;
  DateTime? _selectedDate;
  OverlayEntry? _overlayEntry;
  StreamSubscription? _hidePickerSubscription;
  bool _isShowingDatePicker = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _layerLink = LayerLink();
    _hidePickerSubscription = widget.hidePickerStream?.listen((value) {
      if (value) {
        _hidePicker();
      }
    });
    _initSelectedDate(widget.initialDate);
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _hidePickerSubscription?.cancel();
  }

  _initSelectedDate(DateTime? date) {
    if (date != null) {
      _selectedDate = date;
      _textEditingController.text = _selectedDate!.format('dd-MM-yyy');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showHidePicker();
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GuideTextField(
          labelText: widget.labelText ?? '',
          hintText: '',
          readOnly: true,
          controller: _textEditingController,
          enableBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: _isShowingDatePicker
                  ? AppColors.blackNormal
                  : AppColors.whiteDarken,
            ),
          ),
          suffixIcon: Assets.images.svg.calendarOutline,
        ),
      ),
    );
  }

  _hidePicker() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isShowingDatePicker = false;
    }
    setState(() {});
  }

  _showHidePicker() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isShowingDatePicker = false;
    } else {
      this._overlayEntry = this._createOverlayEntry();
      Overlay.of(context)?.insert(this._overlayEntry!);
      _isShowingDatePicker = true;
    }
    setState(() {});
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: this._layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height),
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.whiteLight,
                    boxShadow: [Decorations.commonShadow()]),
                child: Theme(
                  data: ThemeData(
                    textTheme: TextTheme(
                      caption: ''.s14w500style(),
                      bodyText1: ''.s14w500style(),
                      subtitle2: ''.s14w600style(color: AppColors.blackNormal),
                    ),
                    colorScheme: ColorScheme.light(
                      primary: AppColors.primaryNormal,
                    ),
                  ),
                  child: Container(
                    height: 360,
                    child: CalendarDatePicker(
                      firstDate: widget.firstDate ?? DateTime.now(),
                      initialDate: _selectedDate ?? widget.firstDate ?? DateTime.now(),
                      lastDate: widget.lastDate ?? DateTime(2090),
                      onDateChanged: (DateTime value) {
                        widget.onDateChanged?.call(value);
                        _initSelectedDate(value);
                        _showHidePicker();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
