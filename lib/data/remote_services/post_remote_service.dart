import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:get_it/get_it.dart';

import '../../core/base/base_response.dart';
import '../../core/core.dart';
import '../data.dart';

class PostRemoteService implements IPostRemoteService {
  late final INetworkUtility _networkUtility;

  PostRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<SingleResponse<PostModel>> createPost(
      {required Map<String, dynamic> data}) async {
    final response =
        await _networkUtility.request('v1/posts/', Method.POST, data: data);

    return SingleResponse<PostModel>.fromJson(response);
  }

  @override
  Future<SingleResponse<ReactionModel>> react(
      {required String postId, required String type}) async {
    final response = await _networkUtility
        .request('v1/posts/$postId/react', Method.POST, data: {'type': type});

    return SingleResponse<ReactionModel>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> delReact({required String postId}) async {
    final response = await _networkUtility.request(
        'v1/posts/$postId/del-reaction', Method.DELETE);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<PostModel>> update(
      {required String postId, required Map<String, dynamic> data}) async {
    final response = await _networkUtility
        .request('v1/posts/$postId/', Method.PUT, data: data);

    return SingleResponse<PostModel>.fromJson(response);
  }

  @override
  Future<SingleResponse<SingleType>> delete({required String postId}) async {
    final response =
        await _networkUtility.request('v1/posts/$postId/', Method.DELETE);

    return SingleResponse<SingleType>.fromJson(response);
  }

  @override
  Future<SingleResponse<PostModel>> getById({required String postId}) async {
    final response =
        await _networkUtility.request('v1/posts/$postId/', Method.GET);

    return SingleResponse<PostModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<PostModel>> getPosts(
      {required Map<String, dynamic> query}) async {
    final response = await _networkUtility.request('v1/posts', Method.GET,
        queryParameters: query);

    return PagingListResponse<PostModel>.fromJson(response);
  }

  @override
  Future<PagingListResponse<ReactionModel>> getReactions(
      {required String postId, required Map<String, dynamic> query}) async {
    final response = await _networkUtility.request(
        'v1/posts/$postId/reactions', Method.GET,
        queryParameters: query);

    return PagingListResponse<ReactionModel>.fromJson(response);
  }
}
