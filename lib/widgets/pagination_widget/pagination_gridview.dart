import 'package:flutter/material.dart';
import 'package:lovecook/extensions/extensions.dart';
import 'pagination_helper.dart';
import 'package:visibility_detector/visibility_detector.dart';

///only used for vertical ListView
class PaginationGridView extends StatefulWidget {
  ///your BLOC must be used this mixin [PaginationHelper]
  final PaginationHelper paginationController;

  ///pass into if you want to control another things exclude pagination
  final ScrollController? scrollController;

  ///build your main item
  final IndexedWidgetBuilder itemBuilder;

  ///pass into if you don't wanna use the default loading indicator [VueCircularProgressIndicator]
  final WidgetBuilder? loadingIndicatorBuilder;

  ///have to pass into if [showInitialLoadingEffectItem] is true
  final IndexedWidgetBuilder? loadingEffectItemBuilder;

  final int loadingEffectItemCount;

  final double listPaddingStartAndEnd;

  final Axis scrollDirection;

  final int crossAxisCount;

  final double mainAxisSpacing;

  final double crossAxisSpacing;

  final double childAspectRatio;

  final double itemPercentBeforeLoadMore;

  final bool shrinkWap;

  final EdgeInsetsGeometry? padding;

  final ScrollPhysics? physics;

  PaginationGridView(
      {Key? key,
      required this.paginationController,
      required this.itemBuilder,
      this.scrollController,
      this.loadingIndicatorBuilder,
      this.loadingEffectItemBuilder,
      this.loadingEffectItemCount = 20,
      this.listPaddingStartAndEnd = 0,
      this.scrollDirection = Axis.vertical,
      this.crossAxisCount = 2,
      this.mainAxisSpacing = 0,
      this.crossAxisSpacing = 0,
      this.childAspectRatio = 1,
      this.itemPercentBeforeLoadMore = 30,
      this.shrinkWap = false,
      this.padding,
      this.physics})
      : super(key: key);

  // this assert make sure the load more and loading effect work well

  @override
  _PaginationGridViewState createState() => _PaginationGridViewState();
}

class _PaginationGridViewState extends State<PaginationGridView> {
  late ScrollController _scrollController;

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

  Widget? buildItem(int index) {
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
    final bool isVertical = widget.scrollDirection == Axis.vertical;
    return RefreshIndicator(
      onRefresh: () async {
        widget.paginationController.refresh();
      },
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      color: Theme.of(context).primaryColor,
      child: GridView.builder(
          physics: widget.physics ?? AlwaysScrollableScrollPhysics(),
          padding: widget.padding,
          shrinkWrap: widget.shrinkWap,
          scrollDirection: widget.scrollDirection,
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              childAspectRatio: widget.childAspectRatio,
              crossAxisSpacing: widget.crossAxisSpacing,
              mainAxisSpacing: widget.mainAxisSpacing),
          itemCount: listLength,
          itemBuilder: (BuildContext ctx, index) {
            return Padding(
                padding: EdgeInsets.only(
                    top: isVertical
                        ? (index <= (widget.crossAxisCount - 1)
                            ? widget.listPaddingStartAndEnd
                            : 0)
                        : 0,
                    bottom: isVertical
                        ? (index >= length ? widget.listPaddingStartAndEnd : 0)
                        : 0,
                    left: !isVertical
                        ? (index <= (widget.crossAxisCount - 1)
                            ? widget.listPaddingStartAndEnd
                            : 0)
                        : 0,
                    right: !isVertical
                        ? (index >= length ? widget.listPaddingStartAndEnd : 0)
                        : 0),
                child: buildItem(index));
          }),
    );
  }

  int get listLength {
    if (isFirstLoad) {
      return widget.crossAxisCount;
    } else {
      if (widget.paginationController.canLoadMore) {
        int returnInt =
            (length ~/ widget.crossAxisCount + 2) * widget.crossAxisCount;

        if (length % widget.crossAxisCount == 0) {
          returnInt = returnInt - widget.crossAxisCount;
        }

        return returnInt;
      } else {
        return length;
      }
    }
  }

  bool get isFirstLoad => widget.paginationController.isFirstLoad;

  int get length => widget.paginationController.items.length;
}
