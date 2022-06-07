import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../extensions/textstyle_extension.dart';
import '../../extensions/widget_extension.dart';
import '../../gen/assets.gen.dart';
import '../../resources/resources.dart';
import 'video_player_pack.dart';

class VideoPlayBuilder extends StatefulWidget {
  VideoPlayBuilder(this.controller,
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
  State createState() {
    return _VideoPlayBuilderState();
  }
}

class _VideoPlayBuilderState extends State<VideoPlayBuilder> {
  //? Alignment params
  AlignmentGeometry get _videoAlignment => widget.videoAlignment;
  AlignmentGeometry get _progressBarAlignment => widget.progressBarAlignment;
  AlignmentGeometry get _muteSoundAlignment => widget.muteSoundAlignment;

  bool get _hideMuteSound => widget.hideMuteSound;

  FadeAnimation imageFadeAnim = FadeAnimation(
      child: Assets.images.svg.play
          .svg(color: AppColors.primaryWhite.withOpacity(0.85)));
  late VoidCallback listener;
  late VideoPlayerValue _latestValue;
  late bool _isMute;

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _isMute = false;
    controller.addListener(_updateVideoValue);
    controller.setVolume(1.0);
    controller.play();
  }

  @override
  void dispose() {
    controller.removeListener(_updateVideoValue);
    controller.dispose();
    super.dispose();
  }

  void _updateVideoValue() {
    if (mounted) {
      setState(() {
        _latestValue = controller.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      Align(
        alignment: _videoAlignment,
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: GestureDetector(
            child: Stack(
              children: [
                VideoPlayer(controller),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        VideoPlayerPackUtil.formatDuration(
                                _latestValue.position)
                            .s13w400(color: AppColors.whiteNormal),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 3),
                            child: VideoProgressBar(
                              controller,
                              drawShadow: false,
                              barHeight: 3,
                              handleHeight: 9,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        VideoPlayerPackUtil.formatDuration(
                                _latestValue.duration)
                            .s13w400(color: AppColors.whiteNormal)
                      ],
                    ),
                  ),
                )
              ],
            ),
            onTap: () {
              if (!controller.value.isInitialized) {
                return;
              }
              if (controller.value.isPlaying) {
                imageFadeAnim = FadeAnimation(
                    child: Icon(Icons.pause,
                        color: AppColors.primaryWhite.withOpacity(0.85),
                        size: 70.0));
                controller.pause();
              } else {
                imageFadeAnim = FadeAnimation(
                    child: Assets.images.svg.play
                        .svg(color: AppColors.primaryWhite.withOpacity(0.85)));
                controller.play();
              }
            },
          ),
        ),
      ),
      // Align(
      //   alignment: _progressBarAlignment,
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 80.0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         VideoPlayerPackUtil.formatDuration(_latestValue.position)
      //             .s13w400(color: AppColors.whiteNormal),
      //         SizedBox(width: 10),
      //         Expanded(
      //           child: Container(
      //             margin: EdgeInsets.only(top: 3),
      //             child: VideoProgressBar(
      //               controller,
      //               drawShadow: false,
      //               barHeight: 3,
      //               handleHeight: 9,
      //             ),
      //           ),
      //         ),
      //         SizedBox(width: 10),
      //         VideoPlayerPackUtil.formatDuration(_latestValue.duration)
      //             .s13w400(color: AppColors.whiteNormal)
      //       ],
      //     ),
      //   ),
      // ),
      Visibility(
        visible: !_hideMuteSound,
        child: Align(
            alignment: _muteSoundAlignment,
            child: GestureDetector(
              child: Container(
                  height: 36,
                  width: 36,
                  decoration: new BoxDecoration(
                    color: AppColors.blackNormal.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: _isMute
                      ? Assets.images.svg.volumnOff.svg(fit: BoxFit.none)
                      : Assets.images.svg.volumnOn.svg(fit: BoxFit.none)),
              onTap: () {
                if (_isMute) {
                  _isMute = false;
                  controller.setVolume(1);
                  setState(() {});
                } else {
                  _isMute = true;
                  controller.setVolume(0);
                  setState(() {});
                }
              },
            )),
      ),
      Center(child: imageFadeAnim),
      Center(
          child: controller.value.isBuffering
              ? const SizedBox().appCenterProgressLoading
              : null),
    ];

    return Stack(
      // fit: StackFit.passthrough,
      children: children,
    );
  }
}
