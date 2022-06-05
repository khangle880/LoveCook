import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../extensions/extensions.dart';
import '../../../generated/l10n.dart';
import '../../../resources/resources.dart';
import '../widgets.dart';

class AppManualSyncDialog extends AppDialog {
  final VoidCallback onClickCancel;

  AppManualSyncDialog({
    required this.fileCount,
    this.controller,
    required this.onClickCancel,
  });

  final int fileCount;
  final ManualSyncController? controller;

  @override
  Widget buildChild(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        'In progress'.s16w400(color: AppColors.whiteLight),
        SizedBox(height: 14),
        ManualSyncProgressWidget(
          fileCount: fileCount,
          controller: controller,
        ),
        SizedBox(height: 24),
        FilledButton(
          onPressed: () {
            onClickCancel.call();
          },
          borderRadius: 100.0,
          expand: true,
          backgroundColor: AppColors.blackLight,
          contentBuilder: (c) {
            return 'Cancel'.s16w600(color: AppColors.whiteLight);
          },
        )
      ],
    );
  }
}

class ManualSyncProgressWidget extends StatefulWidget {
  const ManualSyncProgressWidget({
    Key? key,
    required this.fileCount,
    this.controller,
  });

  final int fileCount;
  final ManualSyncController? controller;

  @override
  State<StatefulWidget> createState() => _ManualSyncProgressWidgetState();
}

class _ManualSyncProgressWidgetState extends State<ManualSyncProgressWidget> {
  double _progressWidth = 0.0;
  double _progressMaxWidth = 0.0;

  @override
  void initState() {
    if (widget.controller != null && widget.controller!.isClosed) return;
    widget.controller?.listen((progress) {
      setState(() {
        _progressWidth = _progressMaxWidth * (progress / widget.fileCount);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _progressMaxWidth = constraints.maxWidth;

        return Stack(
          children: [
            Container(
              height: 8.0,
              width: _progressMaxWidth,
              decoration: BoxDecoration(
                color: AppColors.progressBackground,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            AnimatedContainer(
              width: _progressWidth,
              height: 8.0,
              decoration: BoxDecoration(
                color: AppColors.primaryNormal,
                borderRadius: BorderRadius.circular(100),
              ),
              duration: Duration(milliseconds: 300),
            )
          ],
        );
      },
    );
  }
}

/// Controller
///
class ManualSyncController {
  bool get isClosed => _progressStream.isClosed;
  final BehaviorSubject<int> _progressStream = BehaviorSubject<int>.seeded(0);

  Stream<int> get progress => _progressStream.stream;

  void update(int completedCount) {
    if (_progressStream.isClosed) return;
    _progressStream.sink.add(completedCount);
  }

  void listen(Function(int) onProgress) {
    if (_progressStream.isClosed) return;
    _progressStream.listen(onProgress);
  }

  void dispose() {
    _progressStream.close();
  }
}
