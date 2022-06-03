import 'package:flutter/material.dart';

class BorderButton extends StatefulWidget {
  const BorderButton({
    Key? key,
    required this.child,
    required this.color,
    this.outLineButton = false,
    this.margin = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final bool isLoading;
  final bool outLineButton;
  final EdgeInsets margin;
  final VoidCallback onPressed;

  @override
  _BorderButton createState() => _BorderButton();
}

class _BorderButton extends State<BorderButton>
    with SingleTickerProviderStateMixin {
  late bool _isLoading;
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    _isLoading = widget.isLoading;

    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: widget.onPressed,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: 60,
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.outLineButton ? Colors.transparent : widget.color,
            border: Border.all(color: widget.color, width: 2.0),
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          // margin: widget.margin,
          child: _isLoading
              ? const SizedBox(
                  height: 30.0, width: 30.0, child: CircularProgressIndicator())
              : widget.child,
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
