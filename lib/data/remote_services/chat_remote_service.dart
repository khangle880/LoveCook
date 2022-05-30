import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import '../data.dart';
import '../responses/responses.dart';

class ChatRemoteService implements IChatRemoteService {
  late final INetworkUtility _networkUtility;

  ChatRemoteService()
      : _networkUtility = GetIt.I.get<INetworkUtility>(
            instanceName: NetworkConstant.authorizationDomain);

  @override
  Future<List<ChatMessageResponse>> sendMessage(
      {required Map<String, dynamic> params}) async {
    final response =
        await _networkUtility.request('v1/message', Method.POST, data: params);

    List<ChatMessageResponse> listChatMessageResponse =
        chatMessageResponseFromJson(response.data);

    return listChatMessageResponse;
  }
}
