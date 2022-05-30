import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  final VoidCallback? onPressed;
  final Function(String)? onChanged;

  const ChatInputField({Key? key, this.onPressed, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0 / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon(Icons.mic, color: Color(0xFF00BF6D)),
          // SizedBox(width: 20.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0 * 0.75,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF00BF6D).withOpacity(0.05),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  SizedBox(width: 20.0 / 4),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: onChanged,
                      decoration: InputDecoration(
                        hintText: "Type message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.attach_file,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.64),
                  ),
                  SizedBox(width: 20.0 / 4),
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.64),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // print('Hello');
              _controller.clear();
              onPressed?.call();
            },
          )
        ],
      ),
    );
  }
}
