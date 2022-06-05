import 'package:flutter/material.dart';
import 'package:lovecook/widgets/widgets.dart';
import '../../extensions/text_style.dart';

class BottomChangeName extends StatefulWidget {
  final Function(String)? changeName;

  const BottomChangeName({Key? key, this.changeName}) : super(key: key);

  @override
  State<BottomChangeName> createState() => _BottomChangeNameState();
}

class _BottomChangeNameState extends State<BottomChangeName> {
  String username = '';

  Function(String)? get changeName => widget.changeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              'Change your name'.s24w700(),
              SizedBox(height: 30.0),
              TextFieldOutline(
                hintText: 'Name',
                onChanged: (value) {
                  username = value;
                },
              ),
              SizedBox(height: 30.0),
              MaterialInkwellButton(
                title: 'Apply change',
                hasBorder: false,
                onTap: () {
                  changeName?.call(username);
                  Navigator.pop(context);
                },
              )
            ]),
      ),
    );
  }
}
