import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../utils/helper/throttle_helper.dart';

class FavoriteButton extends StatefulWidget {
  final Future<bool> Function(bool value) onClicked;
  final bool initFavorite;
  final bool isFlatDefault;
  final double size;

  const FavoriteButton({
    required this.onClicked,
    required this.size,
    this.initFavorite = false,
    this.isFlatDefault = true,
  });

  @override
  State<StatefulWidget> createState() {
    return _FavoriteButtonState();
  }
}

class _FavoriteButtonState extends State<FavoriteButton>
    with TickerProviderStateMixin {
  bool _isFavorite = false;
  late AnimationController _controller;
  late Function throttledOnClick;
  late ThrottleHelper throttleHelper;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initFavorite;
    throttleHelper = ThrottleHelper();
    throttledOnClick = throttleHelper.throttle(1000, () {
      handleLike();
    });

    _controller = AnimationController(
        vsync: this,
        value: _isFavorite ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300));
  }

  @override
  void didUpdateWidget(covariant FavoriteButton oldWidget) {
    _isFavorite = widget.initFavorite;
    super.didUpdateWidget(oldWidget);
  }

  void handleLike() {
    _isFavorite = !_isFavorite;
    widget.onClicked(_isFavorite).then((value) {
      setState(() {
        _isFavorite = value;
      });
    });
    if (_isFavorite) {
      _controller.animateTo(1.0, duration: Duration(milliseconds: 300));
    } else {
      _controller.animateBack(0, duration: Duration(milliseconds: 300));
    }
  }

  @override
  void dispose() {
    throttleHelper.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        throttledOnClick();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => (_isFavorite
                ? Assets.images.svg.heartFilledRed
                : widget.isFlatDefault
                    ? Assets.images.svg.heartFilled
                    : Assets.images.svg.heartFilledWhite)
            .svg(
          height: widget.size,
          width: widget.size,
        ),
      ),
    );
  }
}
