import '../../../core/base/base_response.dart';
import '../../data.dart';

abstract class IPostRemoteService {
  Future<SingleResponse<PostModel>> createPost(
      {required Map<String, dynamic> data});
  Future<SingleResponse<ReactionModel>> react(
      {required String postId, required String type});
  Future<SingleResponse<SingleType>> delReact({required String postId});
  Future<SingleResponse<PostModel>> getById({required String postId});
  Future<SingleResponse<PostModel>> update(
      {required String postId, required Map<String, dynamic> data});
  Future<SingleResponse<SingleType>> delete({required String postId});
  Future<PagingListResponse<PostModel>> getPosts(
      {required Map<String, dynamic> query});
  Future<PagingListResponse<ReactionModel>> getReactions(
      {required String postId, required Map<String, dynamic> query});
}
