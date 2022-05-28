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
}
