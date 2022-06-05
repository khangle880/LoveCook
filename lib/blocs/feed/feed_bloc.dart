import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

import '../../core/core.dart';
import '../../widgets/pagination_widget/pagination_helper.dart';
import 'feed.dart';

class FeedBloc extends BaseBloc<FeedState> {
  final IPostRepository _postRepository;
  PaginationHelper<PostModel>? postPagination;

  FeedBloc(this._postRepository);

  Future<PagingListResponse<PostModel>> getPosts({required int page}) async {
    final responseEither =
        await _postRepository.getPosts(query: {'page': page});
    return responseEither.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }
}
