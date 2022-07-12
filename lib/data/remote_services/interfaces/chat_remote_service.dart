
import '../../../core/base/base_response.dart';
import '../../responses/chat_message_response.dart';

abstract class IChatRemoteService {
  Future<ListResponse<ChatMessageResponse>> sendMessage(
      {required Map<String, dynamic> params});
}
