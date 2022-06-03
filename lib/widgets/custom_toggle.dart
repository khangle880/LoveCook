import 'package:flutter/material.dart';

import '../resources/resources.dart';

class CustomToggle extends StatefulWidget {
  final Color? activeColor;
  final Color? inactiveColor;
  final bool value;
  final ValueChanged<bool> onChanged;

  // use this function to control update status of toggle
  final Future<bool> Function(bool)? validate;

  CustomToggle({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.validate,
  }) : super(key: key);

  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle>
    with SingleTickerProviderStateMixin {
  final double _iconSize = 28.0;
  late Animation _circleAnimation;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(_animation);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () async {
            bool validToGo = true;

            // validate before update toggle
            if (widget.validate != null) {
              validToGo = await widget.validate!.call(!_value);
              if (!validToGo) {
                return;
              }
            }
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }

            _value = !_value;
            widget.onChanged(_value);
          },
          child: SizedBox(
            width: 52,
            height: 32,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: _circleAnimation.value == Alignment.centerLeft
                    ? widget.inactiveColor ?? AppColors.whiteDarken
                    : widget.activeColor ?? AppColors.primaryNormal,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Align(
                      alignment: _circleAnimation.value,
                      child: Container(
                        width: _iconSize,
                        height: _iconSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NoAnimToggle extends StatelessWidget {
  final bool value;
  final double _iconSize = 28.0;

  NoAnimToggle({required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 32,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: value ? AppColors.primaryNormal : AppColors.whiteDarken),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Stack(
            children: [
              Align(
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: _iconSize,
                  height: _iconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
