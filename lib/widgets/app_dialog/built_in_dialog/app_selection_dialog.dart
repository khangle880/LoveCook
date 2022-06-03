import 'package:flutter/material.dart';
import '../../../extensions/extensions.dart';
import '../../../resources/resources.dart';
import '../../widgets.dart';
import '../app_dialog.dart';

/// Example
///
///  showDialog(
///     context: context,
///     builder: (_) {
///       return AppSelectionDialog(
///         onCancelClicked: () {},
///         onConfirmClicked: () {},
///         title: 'Choose app language',
///         content: Column(
///           children: [
///             '1111'.s16w600(),
///             '2222'.s16w600(),
///           ],
///         ),
///       );
///     });
class AppSelectionDialog extends AppDialog {
  AppSelectionDialog({
    required this.content,
    required this.title,
    this.titleStyle,
    this.onConfirmClicked,
    this.onCancelClicked,
    this.showAction = true,
  });

  final Widget content;
  final String title;
  final TextStyle? titleStyle;
  final bool showAction;
  final VoidCallback? onConfirmClicked;
  final VoidCallback? onCancelClicked;

  @override
  Widget buildChild(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: titleStyle ?? ''.s16w600style(color: AppColors.whiteLight),
        ),
        SizedBox(height: 24),
        content,
        SizedBox(height: 16),
        if (showAction) _renderButtons(),
      ],
    );
  }

  Widget _renderButtons() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: FilledViiButton(
            onPressed: () {
              onCancelClicked?.call();
            },
            expand: true,
            borderRadius: 100,
            backgroundColor: AppColors.blackLight,
            contentBuilder: (c) {
              return 'Cancel'.s16w600(color: AppColors.whiteLight);
            },
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 5,
          child: FilledViiButton(
            onPressed: () {
              onConfirmClicked?.call();
            },
            expand: true,
            borderRadius: 100,
            contentBuilder: (c) {
              return 'Confirm'
                  .s16w600(color: AppColors.primaryLight);
            },
          ),
        )
      ],
    );
  }
}
