import 'chat_state.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../data/responses/responses.dart';
import '../../enums.dart';

class ChatBloc extends BaseBloc<ChatState> {
  final IChatRepository _chatRepository;

  ChatBloc(this._chatRepository);

  Stream<List<ChatMessageResponse>?> get listChatMessage =>
      stateStream.map((event) => event.listChatMessage);

  Future<void> sendMessage(String message) async {
    if (message.length == 0) {
      return;
    }

    final userMessage =
        ChatMessageResponse(text: message, sender: SenderType.user);

    //? Add user message to state
    if (state?.listChatMessage == null || state!.listChatMessage!.isEmpty) {
      final listChatMessage = [userMessage];
      emit(ChatState(state: state, listChatMessage: listChatMessage));
    } else {
      final listChatMessage = state!.listChatMessage;

      listChatMessage!.insert(0, userMessage);
      emit(ChatState(state: state, listChatMessage: listChatMessage));
    }

    //? Add chatbot message to state

    final responseEither =
        await _chatRepository.sendMessage(params: {'message': message});

    responseEither.fold((failure) {}, (data) {
      if (state?.listChatMessage == null || state!.listChatMessage!.isEmpty) {
        emit(ChatState(state: state, listChatMessage: data));
      } else {
        final listChatMessage = state!.listChatMessage;

        listChatMessage!.insertAll(0, data.reversed);
        emit(ChatState(state: state, listChatMessage: listChatMessage));
      }
    });
  }
}
