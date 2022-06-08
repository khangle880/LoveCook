import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import '../../resources/colors.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key, this.file, this.path})
      : assert((file != null) ^ (path != null),
            "you should only enter file or path"),
        super(key: key);

  final File? file;
  final String? path;

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

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
    );
  }

  void initVideoController() async {
    if (widget.file != null) {
      videoPlayerController = VideoPlayerController.file(widget.file!);
    } else {
      videoPlayerController = VideoPlayerController.network(widget.path!);
    }

    videoPlayerController.initialize().then((value) {
      _isLoaded = true;
      setState(() {});
    });
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
          color: AppColors.blurDark,
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
