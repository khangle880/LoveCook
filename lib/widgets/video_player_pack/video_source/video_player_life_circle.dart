import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

/// Player life circle
class PlayerLifeCycle extends StatefulWidget {
  PlayerLifeCycle(this.dataSource, this.loadNetwork, this.childBuilder);

  final VideoWidgetBuilder childBuilder;
  final String dataSource;
  final bool loadNetwork;

  @override
  _PlayerLifeCycleState createState() => _PlayerLifeCycleState();
}

class _PlayerLifeCycleState extends State<PlayerLifeCycle> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = createVideoPlayerController();
    controller.addListener(() {
      if (controller.value.hasError) {}
    });
    controller.initialize();
    controller.setLooping(true);
    controller.play();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.childBuilder(context, controller);
  }

  VideoPlayerController createVideoPlayerController() {
    // return widget.loadNetwork
    //     ? VideoPlayerController.network(widget.dataSource)
    //     : VideoPlayerController.file(File(widget.dataSource));
    return VideoPlayerController.file(File(widget.dataSource));
  }
}
