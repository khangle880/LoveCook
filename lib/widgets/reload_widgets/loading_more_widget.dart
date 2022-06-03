import 'package:flutter/material.dart';

class LoadingMoreWidget extends StatelessWidget {
  const LoadingMoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
    );
  }
}
