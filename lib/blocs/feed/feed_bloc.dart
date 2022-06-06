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

  Future<void> createPost(String content, List<String> listImageData) async {
    if (listImageData.isNotEmpty) {
      for (final imagePath in listImageData) {
        // TODO Handle response either
        _uploadRepository.uploadFileData(filePath: imagePath);
      }
    }

    final responseEither = await _postRepository
        .createPost(data: {"viewRange": "PUBLIC", "content": content});

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
