import 'package:flutter/material.dart';
import '../../extensions/extensions.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'pagination_helper.dart';

///only used for vertical ListView
class PaginationSliverListView extends StatefulWidget {
  ///your BLOC must be used this mixin [PaginationHelper]
  final PaginationHelper paginationController;

  final IndexedWidgetBuilder? separatorBuilder;

  ///build your main item
  final IndexedWidgetBuilder itemBuilder;
  final ScrollController? scrollController;

  ///pass into if you don't wanna use the default loading indicator [VueCircularProgressIndicator]
  final WidgetBuilder? loadingIndicatorBuilder;
  // no item builder
  final WidgetBuilder? emptyBuilder;

  final WidgetBuilder? unloadingIndicatorBuilder;

  final double itemPercentBeforeLoadMore;

  // ignore: use_key_in_widget_constructors
  const PaginationSliverListView({
    required this.paginationController,
    required this.itemBuilder,
    this.loadingIndicatorBuilder,
    this.unloadingIndicatorBuilder,
    this.scrollController,
    this.itemPercentBeforeLoadMore = 30,
    this.separatorBuilder,
    this.emptyBuilder,
  });

  @override
  _PaginationSliverListViewState createState() =>
      _PaginationSliverListViewState();
}

class _PaginationSliverListViewState extends State<PaginationSliverListView> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController ?? ScrollController();
    widget.paginationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(covariant PaginationSliverListView oldWidget) {
    if (oldWidget.paginationController != widget.paginationController) {
      widget.paginationController.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  Widget buildItem(int index) {
    //loading items
    if (isFirstLoad) {
      return widget.loadingIndicatorBuilder?.call(context) ??
          Container(
            child: SizedBox().appCenterProgressLoading,
            margin: EdgeInsets.all(32.0),
          );
    }
    if (index < length) {
      return widget.itemBuilder.call(context, index);
    }
    if (widget.paginationController.canLoadMore) {
      return StreamBuilder<bool>(
          stream: widget.paginationController.bsIsLoadingMore,
          builder: (context, snapshot) {
            return VisibilityDetector(
                key: GlobalKey(),
                onVisibilityChanged: (visibilityInfo) {
                  var visiblePercentage = visibilityInfo.visibleFraction * 100;
                  if (snapshot.data == false &&
                      visiblePercentage > widget.itemPercentBeforeLoadMore) {
                    widget.paginationController.run();
                  }
                },
                child: widget.loadingIndicatorBuilder?.call(context) ??
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox().appCenterProgressLoading,
                    ));
          });
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return listLength == 0
        ? SliverToBoxAdapter(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: (widget.emptyBuilder?.call(context) ?? SizedBox.shrink()),
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
            return index != (listLength - 1)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildItem(index),
                      widget.separatorBuilder?.call(_, index) ??
                          const SizedBox(),
                    ],
                  )
                : buildItem(index);
          }, childCount: listLength));
  }

  int get listLength =>
      widget.paginationController.canLoadMore ? length + 1 : length;

  bool get isFirstLoad => widget.paginationController.isFirstLoad;

  int get length => widget.paginationController.items.length;
}
