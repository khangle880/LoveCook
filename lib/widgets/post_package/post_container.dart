import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../widgets.dart';
import 'post_package.dart';

class PostContainer extends StatelessWidget {
  final PostModel post;

  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

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
            PhotosSlider(
              photoUrls: post.photoUrls ?? [],
              itemMargin: EdgeInsets.symmetric(horizontal: 5.0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: PostStats(post: post),
            ),
          ],
        ),
      ),
    );
  }
}
