import 'package:equatable/equatable.dart';

import '../../data/responses/responses.dart';

class ChatState extends Equatable {
  final bool? success;
  final bool? error;
  final List<ChatMessageResponse>? listChatMessage;

  ChatState({
    ChatState? state,
    bool? success,
    bool? error,
    List<ChatMessageResponse>? listChatMessage,
  })  : success = success ?? state?.success,
        error = error ?? state?.error,
        listChatMessage = listChatMessage ?? state?.listChatMessage;

  @override
  List<Object?> get props => [success, error, listChatMessage];
}
