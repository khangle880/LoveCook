import '../../core/base/base_response.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../data/enum.dart';
import '../../widgets/pagination_widget/pagination_helper.dart';
import 'feed.dart';

class FeedBloc extends BaseBloc<FeedState> {
  final IPostRepository _postRepository;
  final ISearchRepository _searchRepository;
  final IUploadRepository _uploadRepository;

  PaginationHelper<PostModel>? postPagination;

  FeedBloc(
      this._postRepository, this._uploadRepository, this._searchRepository);

  setUser(User user) {
    emit((state ?? FeedState()).copyWith(user: user));
  }

  Future<PagingListResponse<PostModel>> getPosts({required int page}) async {
    Map<String, dynamic> queryParams = {
      'page': page,
      'type': SearchType.post.shortString,
    };
    if (state?.query != null && state!.query!.isNotEmpty)
      queryParams.putIfAbsent('q', () => state!.query);
    if (state?.user != null)
      queryParams.putIfAbsent('creatorId', () => state!.user!.id);
    final responseEither = await _searchRepository.search(query: queryParams);
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data.item!.posts!;
    });
  }

  updateQuery(String? query) {
    emit((state ?? FeedState()).copyWith(query: query));
  }

  Future<void> createPost(
      String content, List<String> listImageData, String? videoPath) async {
    List<String> listImagePath = [];
    String videoUrlPath = '';

    if (videoPath != null) {
      final imageResponseEither =
          await _uploadRepository.uploadVideoData(filePath: videoPath);
      imageResponseEither.fold((failure) {}, (data) {
        videoUrlPath = data.item?.urls?[0] ?? '';
      });
    }

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

  Future<void> reactPost(String? postId, String? emote) async {
    if (postId == null) {
      return;
    }

    if (emote == null || emote == 'Empty') {
      final deleteResponseEither =
          await _postRepository.delReact(postId: postId);
      deleteResponseEither.fold((failure) => null, (data) {
        final currentListPost = postPagination?.items;
        final postIndex = currentListPost
                ?.indexWhere((post) => post.id?.contains(postId) ?? false) ??
            -1;

        currentListPost?[postIndex] = currentListPost[postIndex]
            .copyWith(statusWithMe: StatusWithMe(reaction: null));

        postPagination?.updateList(currentListPost ?? []);
      });

      return;
    }

    // # 1
    final responseEither =
        await _postRepository.react(postId: postId, type: emote);

    responseEither.fold((failure) => null, (data) {
      final currentListPost = postPagination?.items;
      final postIndex = currentListPost
              ?.indexWhere((post) => post.id?.contains(postId) ?? false) ??
          -1;

      currentListPost?[postIndex] = currentListPost[postIndex]
          .copyWith(statusWithMe: StatusWithMe(reaction: data.item));

      postPagination?.updateList(currentListPost ?? []);
    });
  }

  Future<void> uploadImages(List<String> listImageData) async {
    for (final imageData in listImageData) {
      _uploadRepository.uploadFileData(filePath: imageData);
    }
  }
}
