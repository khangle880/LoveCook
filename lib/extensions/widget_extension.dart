import 'package:flutter/material.dart';
import '../../resources/resources.dart';

extension WidgetExt on Widget{
  Widget get appCenterProgressLoading{
    return Center(
      child: Container(
        width: 32,
        height: 32,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.primaryNormal)),
      ),
    );
  }
}

