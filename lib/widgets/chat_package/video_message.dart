import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../data/responses/responses.dart';

class VideoMessage extends StatefulWidget {
  const VideoMessage({
    required this.message,
  });

  final ChatMessageResponse message;

  @override
  State<VideoMessage> createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.message.custom?.youtubeId ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75, // 45% of total width
      child: AspectRatio(
        aspectRatio: 1.6,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: widget.message.custom?.youtubeId != null
                ? YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.amber,
                    progressColors: ProgressBarColors(
                      playedColor: Colors.amber,
                      handleColor: Colors.amberAccent,
                    ),
                  )
                : SizedBox.shrink()),
      ),
    );
  }
}
