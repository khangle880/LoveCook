
import '../../responses/chat_message_response.dart';

abstract class IChatRemoteService {
  Future<List<ChatMessageResponse>> sendMessage(
      {required Map<String, dynamic> params});
}
