import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    Key? key,
    this.file,
    this.path,
    this.backgroundColor,
    this.allowFullScreen = false,
  })  : assert((file != null) ^ (path != null),
            "you should only enter file or path"),
        super(key: key);

  final String? file;
  final String? path;
  final Color? backgroundColor;
  final bool allowFullScreen;

  @override
  VideoWidgetState createState() => VideoWidgetState();
}

class VideoWidgetState extends State<VideoWidget> {
  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    initVideoController();
  }

  void initVideoController() async {
    if (widget.file != null) {
      videoPlayerController = VideoPlayerController.file(File(widget.file!));
    } else {
      videoPlayerController = VideoPlayerController.network(widget.path!);
    }

    videoPlayerController.initialize().then((value) {
      _isLoaded = true;
      setState(() {});
    });
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      showOptions: false,
      allowFullScreen: widget.allowFullScreen,
      allowPlaybackSpeedChanging: false,
      allowMuting: false,
    );
  }

  @override
  void didUpdateWidget(covariant VideoWidget oldWidget) {
    if (oldWidget.file != widget.file || oldWidget.path != widget.path) {
      _isLoaded = false;
      setState(() {});
      initVideoController();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: widget.backgroundColor ?? Colors.white,
          height:
              videoPlayerController.value.aspectRatio * constraints.maxWidth,
          child: Center(
            child: _isLoaded
                ? AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: Chewie(
                      controller: chewieController,
                    ),
                  )
                : CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
