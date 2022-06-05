import 'package:flutter/material.dart';
import 'package:lovecook/extensions/widget_extension.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'pagination_helper.dart';

///only used for vertical ListView
class PaginationListView extends StatefulWidget {
  ///your BLOC must be used this mixin [PaginationHelper]

  ///pass into if you want to control another things exclude pagination
  final ScrollController? scrollController;

  final PaginationHelper paginationController;

  ///build your main item
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;

  ///pass into if you don't wanna use the default loading indicator [VueCircularProgressIndicator]
  final WidgetBuilder? loadingIndicatorBuilder;

  ///have to pass into if [showInitialLoadingEffectItem] is true
  final IndexedWidgetBuilder? loadingEffectItemBuilder;

  final int loadingEffectItemCount;

  final double listPaddingStartAndEnd;

  final Axis scrollDirection;

  final double itemPercentBeforeLoadMore;

  // ignore: use_key_in_widget_constructors
  const PaginationListView({
    required this.itemBuilder,
    required this.paginationController,
    this.separatorBuilder,
    this.scrollController,
    this.loadingIndicatorBuilder,
    this.loadingEffectItemBuilder,
    this.loadingEffectItemCount = 10,
    this.listPaddingStartAndEnd = 0,
    this.scrollDirection = Axis.vertical,
    this.itemPercentBeforeLoadMore = 30,
  });

  @override
  _PaginationListViewState createState() => _PaginationListViewState();
}

class _PaginationListViewState extends State<PaginationListView> {
  late ScrollController _scrollController;
  late Function onUpdate;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    widget.paginationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  Widget buildItem(int index) {
    //loading items
    if (isFirstLoad) {
      return widget.loadingEffectItemBuilder?.call(context, index) ??
          SizedBox().appCenterProgressLoading;
    }
    if ((index) < length) {
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
    final bool isVertical = widget.scrollDirection == Axis.vertical;
    return RefreshIndicator(
      onRefresh: () async {
        widget.paginationController.refresh();
      },
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      color: Theme.of(context).primaryColor,
      child: ListView.separated(
        scrollDirection: widget.scrollDirection,
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              top: isVertical
                  ? (index == 0 ? widget.listPaddingStartAndEnd : 0)
                  : 0,
              bottom: isVertical
                  ? (index == listLength - 1
                      ? widget.listPaddingStartAndEnd
                      : 0)
                  : 0,
              left: isVertical
                  ? 0
                  : (index == 0 ? widget.listPaddingStartAndEnd : 0),
              right: isVertical
                  ? 0
                  : (index == listLength - 1
                      ? widget.listPaddingStartAndEnd
                      : 0),
            ),
            child: buildItem(index),
          );
        },
        separatorBuilder: (context, index) =>
            widget.separatorBuilder?.call(context, index) ?? const SizedBox(),
        itemCount: listLength,
      ),
    );
  }

  int get listLength =>
      widget.paginationController.canLoadMore ? length + 1 : length;

  bool get isFirstLoad => widget.paginationController.isFirstLoad;

  int get length => widget.paginationController.items.length;
}
