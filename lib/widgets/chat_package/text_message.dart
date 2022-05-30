import 'package:flutter/material.dart';

import '../../data/responses/responses.dart';
import '../../enums.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessageResponse? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      padding: EdgeInsets.symmetric(
        horizontal: 20.0 * 0.75,
        vertical: 20.0 / 2,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF00BF6D)
            .withOpacity(message?.sender == SenderType.user ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message?.text ?? 'Error',
        style: TextStyle(
          color: message?.sender == SenderType.user
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
    );
  }
}
