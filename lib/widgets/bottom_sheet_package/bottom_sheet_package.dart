import 'package:flutter/material.dart';
import 'package:lovecook/widgets/bottom_sheet_package/bottom_change_language.dart';
import 'package:lovecook/widgets/bottom_sheet_package/bottom_change_phone.dart';

import 'bottom_change_name.dart';

class ShowCustomBottomSheet {
  static void changeName(BuildContext context, Function(String)? changeName) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return BottomChangeName(
            changeName: changeName,
          );
        });
  }

  static void changePhone(BuildContext context, Function(String)? changePhone) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return BottomChangePhone(
            changePhone: changePhone,
          );
        });
  }

  static void changeLanguage(
      BuildContext context, Function(String)? changeLanguage) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return BottomChangeLanguage(
            changeLanguage: changeLanguage,
          );
        });
  }

  static void changeAvatar(BuildContext context, VoidCallback changeAvatar) {}
}
