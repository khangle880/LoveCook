import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/data/data.dart';

abstract class ICommentRemoteService {
  Future<SingleResponse<CommentModel>> createComment(
      {required Map<String, dynamic> data});
  Future<SingleResponse<SingleType>> react(
      {required String commentId, required String type});
  Future<SingleResponse<SingleType>> delReact({required String commentId});
  Future<SingleResponse<CommentModel>> getById({required String commentId});
  Future<SingleResponse<CommentModel>> update(
      {required String commentId, required Map<String, dynamic> data});
  Future<SingleResponse<SingleType>> delete({required String commentId});
  Future<PagingListResponse<CommentModel>> getComments(
      {required Map<String, dynamic> query});
  Future<PagingListResponse<ReactionModel>> getReactions(
      {required String commentId, required Map<String, dynamic> query});
}
