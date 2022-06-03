import 'package:flutter/material.dart';
import '../../resources/resources.dart';

abstract class AppDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: AppColors.blackNormal,
      child: Container(
        padding: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        child: buildChild(context),
      ),
    );
  }

  Widget buildChild(BuildContext context);
}
