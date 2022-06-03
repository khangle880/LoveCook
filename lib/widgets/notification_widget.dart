import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../resources/resources.dart';

const int MAX_NOTIFICATION = 10;

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {Key? key,
      this.activeColor = AppColors.primaryNormal,
      this.inActiveColor = AppColors.whiteNormal,
      this.onPopRoute})
      : super(key: key);

  final Color activeColor;
  final Color inActiveColor;
  final VoidCallback? onPopRoute;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        // stream: context.read<AppBloc>().notificationCountStream,
        builder: (context, snapshot) {
          final notificationCount = snapshot.data ?? 0;
          return GestureDetector(
            // onTap: () {
            //   Navigator.pushNamed(context, Routes.notification).then((value) {
            //     onPopRoute?.call();
            //   });
            // },
            child: SizedBox(
              width: 28.5,
              height: 24,
              child: Stack(
                children: [
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: SvgPicture.asset(
                  //     VectorImageAssets.ic_notification,
                  //     height: 20,
                  //     color:
                  //         notificationCount == 0 ? inActiveColor : activeColor,
                  //   ),
                  // ),
                  if (notificationCount > 0)
                    Align(
                      alignment: Alignment.topRight,
                      child: Stack(
                        children: [
                          Container(
                            width: 20,
                            height: 16,
                            decoration: BoxDecoration(
                                color: activeColor,
                                borderRadius: BorderRadius.circular(50)),
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: "00".s12w400(
                              color: AppColors.primaryTransparent,
                            ),
                          ),
                          Positioned.fill(
                            child: Center(
                              child: _getDisplay(notificationCount).s12w400(
                                color: AppColors.whiteLight,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }

  String _getDisplay(int notificationCount) {
    if (notificationCount >= MAX_NOTIFICATION) {
      return '9+';
    }
    return notificationCount.toString();
  }
}
