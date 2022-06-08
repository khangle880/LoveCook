import 'package:flutter/material.dart';

import '../../extensions/text_style.dart';
import '../widgets.dart';

class BottomChangeLanguage extends StatefulWidget {
  final Function(String)? changeLanguage;

  const BottomChangeLanguage({Key? key, this.changeLanguage}) : super(key: key);

  @override
  State<BottomChangeLanguage> createState() => _BottomChangeLanguageState();
}

class _BottomChangeLanguageState extends State<BottomChangeLanguage> {
  String language = '';

  Function(String)? get changeLanguage => widget.changeLanguage;

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
              'Change your language'.s24w700(),
              SizedBox(height: 30.0),
              MaterialInkwellButton(
                title: 'VN: Vietnamese',
                hasBorder: false,
                onTap: () {
                  changeLanguage?.call('VN');
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 30.0),
              MaterialInkwellButton(
                title: 'EN: English',
                hasBorder: false,
                onTap: () {
                  changeLanguage?.call('EN');
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 30.0),
            ]),
      ),
    );
  }
}
