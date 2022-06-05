import 'package:flutter/material.dart';
import '../../../extensions/extensions.dart';
import '../../../resources/resources.dart';
import '../../../generated/l10n.dart';
import '../widgets.dart';
import 'app_dialog_base.dart';

/// Example
///
/// showDialog(
///   context: context,
///   builder: (_) {
///   return AppConfirmationDialog(
///       content:'The video has been completed and saved on the library.',
///       isConfirmRight: false,
///       onCancelClicked: () {},
///       onConfirmClicked: () {},
///   );
/// });
class AppConfirmationDialog extends AppDialog {
  AppConfirmationDialog({
    required this.content,
    this.onConfirmClicked,
    this.onCancelClicked,
    this.isConfirmRight = true,
    this.leftTitle,
    this.rightTitle,
  });

  final String content;
  final bool isConfirmRight;
  final VoidCallback? onConfirmClicked;
  final VoidCallback? onCancelClicked;
  final String? leftTitle;
  final String? rightTitle;

  @override
  Widget buildChild(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        content.s15w400(color: AppColors.whiteLight),
        SizedBox(height: 24),
        _renderButtons(),
      ],
    );
  }

  Widget _renderButtons() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: _getButton(!isConfirmRight),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 5,
          child: _getButton(isConfirmRight),
        )
      ],
    );
  }

  Widget _getButton(bool v) {
    if (v) {
      return FilledButton(
        onPressed: () {
          onConfirmClicked?.call();
        },
        expand: true,
        borderRadius: 100,
        contentBuilder: (c) {
          return 'Confirm'.s16w600(color: AppColors.primaryLight);
        },
      );
    } else {
      return FilledButton(
        onPressed: () {
          onCancelClicked?.call();
        },
        expand: true,
        borderRadius: 100,
        backgroundColor: AppColors.blackLight,
        contentBuilder: (c) {
          return '${leftTitle ?? 'Cancel'}'
              .s16w600(color: AppColors.whiteLight);
        },
      );
    }
  }
}
