import 'package:flutter/rendering.dart';

import '../../../resources/colors.dart';

class ProgressBarColors {
  ProgressBarColors({
    Color playedColor = AppColors.primaryNormal,
    Color bufferedColor = AppColors.grayNormal,
    Color handleColor = AppColors.primaryWhite,
    Color backgroundColor = AppColors.grayNormal,
  })  : playedPaint = Paint()..color = playedColor,
        bufferedPaint = Paint()..color = bufferedColor,
        handlePaint = Paint()..color = handleColor,
        backgroundPaint = Paint()..color = backgroundColor;

  final Paint playedPaint;
  final Paint bufferedPaint;
  final Paint handlePaint;
  final Paint backgroundPaint;
}
