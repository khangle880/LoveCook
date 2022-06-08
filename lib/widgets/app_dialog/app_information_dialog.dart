import 'package:flutter/material.dart';

import '../../../extensions/extensions.dart';
import '../../../resources/resources.dart';
import '../widgets.dart';

/// Example
///
/// showDialog(
///   context: context,
///   builder: (_) {
///     return AppConfirmationDialog(content: 'The video has been completed and saved on the library.');
///   }
/// );
class AppInformationDialog extends AppDialog {
  AppInformationDialog({
    required this.content,
    this.buttonTitle,
  });

  final String? buttonTitle;
  final String content;

  @override
  Widget buildChild(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        content.s15w400(color: AppColors.whiteLight),
        SizedBox(height: 24),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          expand: true,
          borderRadius: 100,
          contentBuilder: (c) {
            return (buttonTitle ?? 'Confirm')
                .s16w600(color: AppColors.primaryLight);
          },
        )
      ],
    );
  }
}
