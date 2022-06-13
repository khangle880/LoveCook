import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/data.dart';
import '../../utils/utils.dart';
import '../widgets.dart';

class PostContainer extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onCommentPress;
  final Function(String?)? onReactChange;

  const PostContainer(
      {Key? key, required this.post, this.onCommentPress, this.onReactChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PostHeader(post: post),
                  const SizedBox(height: 4.0),
                  Text(post.content ?? ''),
                  post.photoUrls != null && post.photoUrls!.isNotEmpty
                      ? const SizedBox(height: 10.0)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            MediaSliderWidget(
              videoPath: post.videoUrl,
              photoPaths: post.photoUrls,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: PostStats(
                post: post,
                onCommentPress: onCommentPress,
                onReactChange: onReactChange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
