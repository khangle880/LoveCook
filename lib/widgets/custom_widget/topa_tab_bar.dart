import 'package:flutter/material.dart';

import '../../resources/colors.dart';

class TopaTabBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;
  final bool isBottomIndicator;

  const TopaTabBar({
    required this.icons,
    required this.selectedIndex,
    required this.onTap,
    this.isBottomIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        border: isBottomIndicator
            ? Border(
                bottom: BorderSide(
                  color: AppColors.successNormal,
                  width: 3.0,
                ),
              )
            : Border(
                top: BorderSide(
                  color: AppColors.successNormal,
                  width: 3.0,
                ),
              ),
      ),
      tabs: icons
          .asMap()
          .map((i, e) => MapEntry(
                i,
                Tab(
                  icon: Icon(
                    e,
                    color: i == selectedIndex
                        ? AppColors.successNormal
                        : Colors.black45,
                    size: 30.0,
                  ),
                ),
              ))
          .values
          .toList(),
      onTap: onTap,
    );
  }
}
