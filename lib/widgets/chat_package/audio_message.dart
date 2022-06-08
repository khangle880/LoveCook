import 'package:flutter/material.dart';

import '../../data/responses/responses.dart';
import '../../enums.dart';

class AudioMessage extends StatelessWidget {
  final ChatMessageResponse? message;

  const AudioMessage({Key? key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0 * 0.75,
        vertical: 20.0 / 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFF00BF6D)
            .withOpacity(message?.sender == SenderType.user ? 1 : 0.1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: message?.sender == SenderType.user
                ? Colors.white
                : Color(0xFF00BF6D),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0 / 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: message?.sender == SenderType.user
                        ? Colors.white
                        : Color(0xFF00BF6D).withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: message?.sender == SenderType.user
                            ? Colors.white
                            : Color(0xFF00BF6D),
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "0.37",
            style: TextStyle(
                fontSize: 12,
                color:
                    message?.sender == SenderType.user ? Colors.white : null),
          ),
        ],
      ),
    );
  }
}
