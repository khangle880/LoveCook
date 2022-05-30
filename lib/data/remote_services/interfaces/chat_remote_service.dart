import 'package:viiv/data/responses/responses.dart';

abstract class IChatRemoteService {
  Future<List<ChatMessageResponse>> sendMessage(
      {required Map<String, dynamic> params});
}
