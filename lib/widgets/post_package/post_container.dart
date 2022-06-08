import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/data.dart';
import '../../utils/utils.dart';
import '../widgets.dart';

class PostContainer extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onCommentPress;

  const PostContainer({Key? key, required this.post, this.onCommentPress})
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
            post.photoUrls != null && post.photoUrls!.isNotEmpty
                ? _buildImageSlider()
                : const SizedBox.shrink(),
            post.videoUrl != null && post.videoUrl!.isNotEmpty
                ? _buildVideoSlider()
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: PostStats(
                post: post,
                onCommentPress: onCommentPress,
              ),
            ),
          ],
        ),
      ),
    );
  }

  CarouselSlider _buildVideoSlider() {
    return CarouselSlider(
      options: CarouselOptions(height: 300.0, enableInfiniteScroll: false),
      items: [
        VideoWidget(path: AppConfig.instance.formatLink(post.videoUrl!))
      ],
    );
  }

  CarouselSlider _buildImageSlider() {
    return CarouselSlider(
      options: CarouselOptions(height: 300.0),
      items: post.photoUrls!.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.transparent),
                child: Image(
                    image: CachedNetworkImageProvider(
                  AppConfig.instance.formatLink(imageUrl),
                )));
          },
        );
      }).toList(),
    );
  }
}
