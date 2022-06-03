import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'reload_view.dart';
import 'loading_more_widget.dart';

class ReloadGridView extends StatelessWidget {
  final int? itemCount;
  final int? cacheScreenQty;
  final int? crossAxisCount;
  final double? childAspectRatio;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final ReloadCallback? onRefresh;
  final ReloadCallback? onReachEnd;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? loadingIndicatorBuilder;
  final bool? isLoadingMore;
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final String? noDataMessage;

  final Map<String, dynamic> _data;
  static const String _loadingMoreKey = 'is_loading_more';

  ReloadGridView({
    Key? key,
    required this.itemBuilder,
    this.controller,
    this.onReachEnd,
    this.onRefresh,
    this.itemCount,
    this.isLoadingMore,
    this.padding,
    this.loadingIndicatorBuilder,
    this.shrinkWrap,
    this.physics,
    this.cacheScreenQty,
    this.noDataMessage,
    this.crossAxisCount,
    this.childAspectRatio,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
  })  : _data = {},
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    if ((itemCount ?? 0) <= 0) {
      return Container(
        width: screenSize.width + 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(noDataMessage ?? '', style: theme.textTheme.caption),
            Positioned.fill(
              child: ReloadView(
                onRefresh: onRefresh,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: double.infinity,
                        height: screenSize.height + 100.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _child = NotificationListener(
      onNotification: _onNotification,
      child: CustomScrollView(
        physics: physics ?? AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: (padding ?? EdgeInsets.zero),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount ?? 0,
                childAspectRatio: childAspectRatio ?? 1.0,
                crossAxisSpacing: crossAxisSpacing ?? 8.0,
                mainAxisSpacing: mainAxisSpacing ?? 8.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return itemBuilder(context, index);
                },
                childCount: itemCount ?? 0,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildLoading(context),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
        ],
      ),
    );
    return onRefresh == null
        ? _child
        : ReloadView(
            onRefresh: onRefresh,
            child: _child,
          );
  }

  Widget _buildLoading(BuildContext context) {
    return (isLoadingMore ?? false)
        ? (loadingIndicatorBuilder != null
            ? loadingIndicatorBuilder!.call(context, 0)
            : LoadingMoreWidget())
        : const SizedBox();
  }

  bool _onNotification(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics.atEdge &&
        metrics.pixels != 0 &&
        (_data['$_loadingMoreKey'] ?? false) == false) {
      _data['$_loadingMoreKey'] = true;
      if (onReachEnd != null) {
        onReachEnd?.call().then((value) => _data['$_loadingMoreKey'] = false);
      } else {
        _data['$_loadingMoreKey'] = false;
      }
    }
    return false;
  }
}
