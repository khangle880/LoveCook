import 'dart:typed_data';

import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

import '../../core/core.dart';
import '../../widgets/pagination_widget/pagination_helper.dart';
import 'feed.dart';

class FeedBloc extends BaseBloc<FeedState> {
  final IPostRepository _postRepository;
  final IUploadRepository _uploadRepository;

  PaginationHelper<PostModel>? postPagination;

  FeedBloc(this._postRepository, this._uploadRepository);

  Future<PagingListResponse<PostModel>> getPosts({required int page}) async {
    final responseEither =
        await _postRepository.getPosts(query: {'page': page});
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<void> createPost(String content, List<String> listImageData,
      List<String> listVideoPath) async {
    List<String> listImagePath = [];
    String videoUrlPath = '';

    if (listVideoPath.isNotEmpty) {
      for (final videoPath in listVideoPath) {
        final imageResponseEither =
            await _uploadRepository.uploadVideoData(filePath: videoPath);
        imageResponseEither.fold((failure) {}, (data) {
          videoUrlPath = data.item?.urls?[0] ?? '';
        });
      }
    }

    print(videoUrlPath);

    if (listImageData.isNotEmpty) {
      for (final imagePath in listImageData) {
        final imageResponseEither =
            await _uploadRepository.uploadFileData(filePath: imagePath);
        imageResponseEither.fold((failure) {}, (data) {
          listImagePath.addAll(data.item?.urls ?? []);
        });
      }
    }

    final data = {
      "viewRange": "PUBLIC",
      "content": content,
      'photoUrls': listImagePath,
    };

    if (videoUrlPath.isNotEmpty) {
      data['videoUrl'] = videoUrlPath;
    }

    final responseEither = await _postRepository.createPost(data: data);

    responseEither.fold((failer) {}, (data) {
      final postContent = data.item;

      if (postContent != null) {
        final currentListPost = postPagination?.items ?? [];
        currentListPost.insert(0, postContent);
        postPagination?.updateList(currentListPost);
      }
    });
  }

  Future<void> uploadImages(List<String> listImageData) async {
    for (final imageData in listImageData) {
      _uploadRepository.uploadFileData(filePath: imageData);
    }
  }
}
