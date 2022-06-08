import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../gen/assets.gen.dart';
import '../../resources/resources.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({Key? key, this.controller, this.onSubmitted})
      : super(key: key);
  final TextEditingController? controller;
  final Function(String value)? onSubmitted;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
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
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    );

    return Container(
      height: 36,
      child: TextField(
        onSubmitted: widget.onSubmitted,
        textInputAction: TextInputAction.search,
        controller: widget.controller,
        style: ''.s16w400style(color: AppColors.blackNormal),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.whiteNormal,
          hintStyle: ''.s16w400style(
            color: AppColors.grayLight,
          ),
          hintText: "Search",
          contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          prefixIcon: Container(
            padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
            child: Assets.images.svg.searchOutline.svg(height: 18, width: 18,color: AppColors.blackDarken),
          ),
          suffixIcon: _isEmptyText
              ? null
              : _buildSuffixIcon(Assets.images.svg.closeCircle),
        ),
      ),
    );
  }

  Widget _buildSuffixIcon(SvgGenImage svgGenImage) {
    // return Assets.images.svg.icClose.svg();
    return Material(
      color: Colors.transparent,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        splashRadius: 30 / 2,
        onPressed: () {
          _controller.clear();
          widget.onSubmitted?.call("");
          setState(() {});
        },
        icon: Assets.images.svg.close.svg(color: AppColors.blackDarken),
      ),
    );
  }
}
