import 'package:flutter/material.dart';

import '../../extensions/text_style.dart';
import '../widgets.dart';

class BottomChangeBio extends StatefulWidget {
  final Function(String)? changeBio;

  const BottomChangeBio({Key? key, this.changeBio}) : super(key: key);

  @override
  State<BottomChangeBio> createState() => _BottomChangeBioState();
}

class _BottomChangeBioState extends State<BottomChangeBio> {
  String username = '';

  Function(String)? get changeName => widget.changeBio;

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
              'Change your bio'.s24w700(),
              SizedBox(height: 30.0),
              TextFieldOutline(
                hintText: 'Bio',
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
