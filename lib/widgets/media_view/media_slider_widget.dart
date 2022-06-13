import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lovecook/extensions/extensions.dart';

import '../../resources/resources.dart';
import '../../utils/utils.dart';
import '../pick_media/pick_media.dart';

class MediaSliderWidget extends StatelessWidget {
  const MediaSliderWidget({
    Key? key,
    this.videoPath,
    this.photoPaths,
    this.showHeader = false,
  }) : super(key: key);
  final String? videoPath;
  final List<String>? photoPaths;
  final bool showHeader;

  Widget wrapWidget({required Widget child}) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(color: Colors.transparent),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (videoPath == null && (photoPaths ?? []).isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader) "Media".s14w600(color: AppColors.successDarken),
        SizedBox(height: 10),
        CarouselSlider(
          options: CarouselOptions(
            height: 300.0,
            enableInfiniteScroll: false,
          ),
          items: [
            if (videoPath != null) wrapWidget(child: buildVideo(videoPath)),
            ...(photoPaths ?? []).map((imageData) {
              return wrapWidget(
                  child: imageData.contains('/storage')
                      ? Image.file(File(imageData), fit: BoxFit.cover)
                      : CachedNetworkImage(
                          imageUrl: AppConfig.instance.formatLink(imageData),
                          placeholder: (context, url) => Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          fit: BoxFit.cover,
                        ));
            }).toList()
          ],
        ),
      ],
    );
  }

  Widget buildVideo(String? videoPath) {
    if (videoPath == null) return SizedBox.shrink();
    return Builder(
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          child: VideoWidget(
            backgroundColor: AppColors.blurDark,
            file: videoPath.contains('/storage') ? videoPath : null,
            path: !videoPath.contains('/storage')
                ? AppConfig.instance.formatLink(videoPath)
                : null,
          ),
        );
      },
    );
  }
}
