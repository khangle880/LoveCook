import 'package:flutter/material.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../core/core.dart';
import '../../../data/responses/chat_message_response.dart';
import '../../../widgets/chat_package/chat_package.dart';

class ChatPage extends StatefulWidget {
  final ChatBloc bloc;

  const ChatPage(this.bloc);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends BaseState<ChatPage, ChatBloc> {
  String message = '';
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  bool get isCustomLayout => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: StreamBuilder<List<ChatMessageResponse>?>(
                  stream: bloc.listChatMessage,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox.shrink(),
                      );
                    }

                    final List<ChatMessageResponse>? listMessages =
                        snapshot.data;

                    return ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: listMessages!.length,
                      itemBuilder: (context, index) => Message(
                        message: listMessages[index],
                        chatBloc: bloc,
                      ),
                    );
                  }),
            ),
          ),
          ChatInputField(
            onChanged: (textValue) {
              message = textValue;
            },
            onPressed: () {
              bloc.sendMessage(message);
              Future.delayed(const Duration(milliseconds: 100), () {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInQuad,
                  );
                }
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  ChatBloc get bloc => widget.bloc;
}
