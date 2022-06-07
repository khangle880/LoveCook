import 'package:lovecook/blocs/feed_comment/feed_comment.dart';
import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/core/core.dart';
import 'package:lovecook/data/data.dart';
import 'package:lovecook/widgets/pagination_widget/pagination_helper.dart';

class FeedCommentBloc extends BaseBloc<FeedCommentState> {
  final ICommentRepository _commentRepository;

  PaginationHelper<CommentModel>? commentPagination;

  FeedCommentBloc(this._commentRepository);

  Future<PagingListResponse<CommentModel>> getComments(
      {required String postId, required int page}) async {
    final responseEither = await _commentRepository
        .getComments(query: {'postId': postId, 'page': page});
    return responseEither.fold(
        (failure) => Future.error(failure), (data) => data);
  }

  Future<void> postComment(
      {required String postId,
      String? comment,
      String? imagePath,
      String? videoPath}) async {
    final responseEither = await _commentRepository
        .createComment(data: {'postId': postId, 'content': comment});

    responseEither.fold((failuer) {}, (data) {
      final comment = data.item;

      if (comment != null) {
        final currentCommentList = commentPagination?.items ?? [];
        currentCommentList.insert(0, comment);
        commentPagination?.updateList(currentCommentList);
      }
    });
  }
}
