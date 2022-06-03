import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lovecook/widgets/widgets.dart';
import '../../extensions/text_style.dart';

class BottomChangePhone extends StatefulWidget {
  final Function(String)? changePhone;

  const BottomChangePhone({Key? key, this.changePhone}) : super(key: key);

  @override
  State<BottomChangePhone> createState() => _BottomChangePhoneState();
}

class _BottomChangePhoneState extends State<BottomChangePhone> {
  String phone = '';

  Function(String)? get changePhone => widget.changePhone;

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
              'Change your phone'.s24w700(),
              SizedBox(height: 30.0),
              TextFieldOutline(
                hintText: 'Phone',
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  phone = value;
                },
              ),
              SizedBox(height: 30.0),
              MaterialInkwellButton(
                title: 'Apply change',
                hasBorder: false,
                onTap: () {
                  changePhone?.call(phone);
                  Navigator.pop(context);
                },
              )
            ]),
      ),
    );
  }
}
