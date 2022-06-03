import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1E6DEB);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color primaryBlack = Color(0xFF000000);
  static const Color primaryDark = Color(0xFF0043b8);
  static const Color primaryLight = Color(0xFF6c9bff);
  static const Color primaryGradientDark = Color(0xFF6c9bff);
  static const Color primaryGradientLight = Color(0xFF6c9bff);

  static const Color white = const Color(0xffffffff);
  static const Color mediumBlue = const Color(0xff4A64FE);

  static const Color scaffold = Color(0xFFF0F2F5);

  static const Color facebookBlue = Color(0xFF1777F2);

  static const LinearGradient createRoomGradient = LinearGradient(
    colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
  );

  static const Color online = Color(0xFF4BCB1F);

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );

  static const Color primaryTransparent = Colors.transparent;

  static const Color primaryNormal = Color(0xFFF04287);
  static const Color primaryDarken = Color(0xFFDB086A);

  static const Color secondaryNormal = Color(0xFF58BFF9);
  static const Color secondaryLight = Color(0xFFDBF5FE);
  static const Color secondaryDarken = Color(0xFF3588D5);

  static const Color blackNormal = Color(0xFF323032);
  static const Color blackLight = Color(0xFF4A4549);
  static const Color blackDarken = Color(0xFF202020);

  static const Color grayNormal = Color(0xFF8C8C8C);
  static const Color grayLight = Color(0xFFBABFBF);
  static const Color grayDarken = Color(0xFF757575);

  static const Color whiteNormal = Color(0xFFF2F1F1);
  static const Color whiteLight = Color(0xFFFFFFFF);
  static const Color whiteDarken = Color(0xFFC7C5C6);
  static const Color whiteSplash = Color(0xFFF2F2F2);

  static const Color successNormal = Color(0xFF39C492);
  static const Color successLight = Color(0xFFE6FEF5);
  static const Color successDarken = Color(0xFF098668);

  static const Color errorNormal = Color(0xFFFF9B26);
  static const Color errorLight = Color(0xFFFFD5A4);
  static const Color errorDarken = Color(0xFFE48516);

  static const Color borderLight = Color(0xFFE1E5E5);

  static const Color progressBackground = Color(0xFFE1E5E5);

  static const Color bgNormal = Color(0xFF2E2E36);
  static const Color bgDarken = Color(0xFF1C1C1E);

  static const Color blurDark = Color(0xFF101010);

  static LinearGradient blurLayer = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF1F1B1E).withOpacity(0.8),
        Color(0xFF1F1B1E).withOpacity(0.35),
        Color(0xFF1F1B1E).withOpacity(0.8)
      ]);

  static LinearGradient blueLayer = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF0B0418).withOpacity(0.1),
        Color(0xFF0B0418).withOpacity(1)
      ]);

  static const Color primaryGreyBlur = Color(0xFFCCCCCC);
  static const Color tagColor = Color(0xFF48E0E4);
}
