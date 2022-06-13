import 'package:flutter/material.dart';
import 'package:lovecook/widgets/bottom_sheet_package/bottom_search_post.dart';

import '../../data/data.dart';
import 'bottom_add_post.dart';
import 'bottom_change_language.dart';
import 'bottom_change_name.dart';
import 'bottom_change_phone.dart';

class ShowCustomBottomSheet {
  static void searchPost(BuildContext context, Function(String)? onSearchCall) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return BottomSearchPost(
            onSearchCall: onSearchCall,
          );
        });
  }

  static void addPost(BuildContext context, User? userInfor,
      final Function(String, List<String>, String?)? onPostCall) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return BottomAddPost(
            userInfor: userInfor,
            onPostCall: onPostCall,
          );
        });
  }

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
