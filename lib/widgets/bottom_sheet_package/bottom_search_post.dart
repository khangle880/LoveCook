import 'package:flutter/material.dart';

import '../../extensions/text_style.dart';
import '../widgets.dart';

class BottomSearchPost extends StatefulWidget {
  final Function(String)? onSearchCall;

  const BottomSearchPost({this.onSearchCall});

  @override
  State<BottomSearchPost> createState() => _BottomSearchPostState();
}

class _BottomSearchPostState extends State<BottomSearchPost> {
  String query = '';

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
              'Search post'.s24w700(),
              SizedBox(height: 30.0),
              TextFieldOutline(
                hintText: 'Post',
                onChanged: (value) {
                  query = value;
                },
              ),
              SizedBox(height: 30.0),
              MaterialInkwellButton(
                title: 'Apply change',
                hasBorder: false,
                onTap: () {
                  widget.onSearchCall?.call(query);
                  Navigator.pop(context);
                },
              )
            ]),
      ),
    );
  }
}
