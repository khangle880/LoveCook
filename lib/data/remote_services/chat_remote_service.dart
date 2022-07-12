import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:lovecook/core/base/base_response.dart';

import '../../core/core.dart';
import '../data.dart';
import '../responses/responses.dart';

class ChatRemoteService implements IChatRemoteService {
  late final INetworkUtility _networkUtility;

  ChatRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<ListResponse<ChatMessageResponse>> sendMessage(
      {required Map<String, dynamic> params}) async {
    final response =
        await _networkUtility.request('v1/message', Method.POST, data: params);

    ListResponse<ChatMessageResponse> listChatMessageResponse =
        ListResponse<ChatMessageResponse>.fromJson(response);

    log(response.data.toString());

    return listChatMessageResponse;
  }
}
