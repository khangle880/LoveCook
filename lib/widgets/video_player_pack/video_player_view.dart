import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../extensions/widget_extension.dart';
import 'video_player_pack.dart';

class VideoPlayerView extends StatefulWidget {
  VideoPlayerView(this.controller,
      {this.videoAlignment = Alignment.center,
      this.progressBarAlignment = const Alignment(0, 0.75),
      this.muteSoundAlignment = const Alignment(0.9, 0.6),
      this.hideMuteSound = false});

  final VideoPlayerController controller;
  final AlignmentGeometry videoAlignment;
  final AlignmentGeometry progressBarAlignment;
  final AlignmentGeometry muteSoundAlignment;

  final bool hideMuteSound;

  @override
  VideoPlayerViewState createState() => VideoPlayerViewState();
}

class VideoPlayerViewState extends State<VideoPlayerView> {
  //? Alignment params
  AlignmentGeometry get _videoAlignment => widget.videoAlignment;

  AlignmentGeometry get _progressBarAlignment => widget.progressBarAlignment;

  AlignmentGeometry get _muteSoundAlignment => widget.muteSoundAlignment;

  //

  //? Widget params
  bool get _hideMuteSound => widget.hideMuteSound;

  //

  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  late VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.isInitialized) {
        initialized = controller.value.isInitialized;
        setState(() {});
      }
    };
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return VideoPlayBuilder(
        controller,
        videoAlignment: _videoAlignment,
        progressBarAlignment: _progressBarAlignment,
        muteSoundAlignment: _muteSoundAlignment,
        hideMuteSound: _hideMuteSound,
      );
    } else {
      return SizedBox().appCenterProgressLoading;
    }
  }
}
