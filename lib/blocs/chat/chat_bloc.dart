import 'dart:developer';

import 'chat_state.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../data/responses/responses.dart';
import '../../enums.dart';

class ChatBloc extends BaseBloc<ChatState> {
  final IChatRepository _chatRepository;

  ChatBloc(this._chatRepository);

  void init() {
    _chatRepository.sendMessage(params: {'message': 'Xóa lịch sử'});
    addAllAwait([
      ChatMessageResponse(
        text:
            'Xin chào bạn mình là trợ lý ảo sẽ giúp bạn trong viêc tìm kiếm món ăn',
      ),
      ChatMessageResponse(
        text:
            'Mình có thể hỗ trợ bạn tìm kiếm công thức món ăn dựa trên nguyên liệu, cách nấu ăn và chế độ dinh dưỡng của bạn',
      ),
      ChatMessageResponse(
        text:
            'Bạn có sẳn nguyên liệu nào chưa, bạn có thể nói với mình nguyên liệu mà bạn muốn chế biến nhé.',
      ),
      ChatMessageResponse(
        text: 'Sau đó mình sẽ tìm các món ngon liên quan cho bạn ^.^',
      ),
    ]);
  }

  Stream<List<ChatMessageResponse>?> get listChatMessage =>
      stateStream.map((event) => event.listChatMessage);

  void clearMessage() async {
    print(state?.listChatMessage);
    emit(ChatState(state: state, listChatMessage: []));
  }

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

    responseEither.fold((failure) {
      final listChatMessage = state!.listChatMessage;

      listChatMessage!.insert(
          0,
          ChatMessageResponse(
            text:
                'Ôi xin lỗi bạn, có chút vấn đề xảy ra nên mình trả lời bạn sau nhá.',
          ));
      emit(ChatState(state: state, listChatMessage: listChatMessage));
    }, (data) {
      if ((data.items ?? []).isEmpty || !data.success) {
        final listChatMessage = state!.listChatMessage;

        listChatMessage!.insert(
            0,
            ChatMessageResponse(
              text:
                  'Ôi xin lỗi bạn, có chút vấn đề xảy ra nên mình trả lời bạn sau nhá.',
            ));
        emit(ChatState(state: state, listChatMessage: listChatMessage));
      }
      addAllAwait(data.items ?? []);
    });
  }

  void addAllAwait(List<ChatMessageResponse> messages) async {
    for (final message in messages) {
      emit(ChatState(
          state: state,
          listChatMessage: (state!.listChatMessage ?? [])..insert(0, message)));
      await Future.delayed(Duration(milliseconds: 800));
    }
  }
}
