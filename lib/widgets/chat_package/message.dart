import 'package:flutter/material.dart';
import 'package:lovecook/widgets/chat_package/video_message.dart';

import '../../blocs/chat/chat_bloc.dart';
import '../../data/responses/responses.dart';
import '../../enums.dart';
import '../widgets.dart';

class Message extends StatelessWidget {
  const Message({Key? key, required this.message, required this.chatBloc})
      : super(key: key);

  final ChatMessageResponse message;
  final ChatBloc chatBloc;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessageResponse message) {
      print(message);
      return Column(
        children: [
          message.text != null
              ? TextMessage(
                  message: message,
                )
              : SizedBox.shrink(),
          message.image != null
              ? ImageMessage(
                  message: message,
                )
              : SizedBox.shrink(),
          message.buttons != null
              ? ColumnBuilder(
                  itemCount: message.buttons!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: MaterialInkwellButton(
                      title: message.buttons?[index].title ?? 'Errro',
                      hasBorder: false,
                      constraints: BoxConstraints(maxWidth: 200),
                      onTap: () {
                        chatBloc
                            .sendMessage(message.buttons?[index].payload ?? '');
                      },
                    ),
                  ),
                )
              : SizedBox.shrink(),
          message.custom?.youtubeId != null
              ? VideoMessage(message: message)
              : SizedBox.shrink()
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: message.sender == SenderType.user
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          messageContaint(message),
          // if (message.isSender) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  const MessageStatusDot({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor() {
      return Color(0xFF00BF6D);
    }

    return Container(
      margin: EdgeInsets.only(left: 20.0 / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
