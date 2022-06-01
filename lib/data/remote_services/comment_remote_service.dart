import 'package:get_it/get_it.dart';
import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/core/core.dart';
import 'package:lovecook/data/data.dart';

class CommentRemoteService implements ICommentRemoteService {
  late final INetworkUtility _networkUtility;

  CommentRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<SingleResponse<CommentModel>> createComment(
      {required Map<String, dynamic> data}) async {
    final response = await _networkUtility.request('v1/comments/', Method.POST,
        data: data);

    return SingleResponse<CommentModel>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> react(
      {required String commentId, required String type}) async {
    final response = await _networkUtility.request(
        'v1/comments/$commentId/react', Method.POST);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> delReact(
      {required String commentId}) async {
    final response = await _networkUtility.request(
        'v1/comments/$commentId/del-reaction', Method.DELETE);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<CommentModel>> update(
      {required String commentId, required Map<String, dynamic> data}) async {
    final response = await _networkUtility
        .request('v1/comments/$commentId/', Method.PUT, data: data);

    return SingleResponse<CommentModel>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> delete({required String commentId}) async {
    final response =
        await _networkUtility.request('v1/comments/$commentId/', Method.DELETE);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<CommentModel>> getById(
      {required String commentId}) async {
    final response =
        await _networkUtility.request('v1/comments/$commentId/', Method.GET);

    return SingleResponse<CommentModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<CommentModel>> getComments(
      {required Map<String, dynamic> query}) async {
    final response = await _networkUtility.request('v1/comments', Method.GET,
        queryParameters: query);

    return PagingListResponse<CommentModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<ReactionModel>> getReactions(
      {required String commentId, required Map<String, dynamic> query}) async {
    final response = await _networkUtility.request(
        'v1/comments/$commentId/reactions', Method.GET,
        queryParameters: query);

    return PagingListResponse<ReactionModel>.fromJson(response);
  }
}
