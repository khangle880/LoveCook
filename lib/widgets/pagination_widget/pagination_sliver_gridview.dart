import 'package:flutter/material.dart';
import 'package:lovecook/extensions/extensions.dart';
import 'pagination_helper.dart';
import 'package:visibility_detector/visibility_detector.dart';

///only used for vertical ListView
class PaginationSliverGridView extends StatefulWidget {
  ///your BLOC must be used this mixin [PaginationHelper]
  final PaginationHelper paginationController;

  ///pass into if you want to control another things exclude pagination
  final ScrollController scrollController;

  ///build your main item
  final IndexedWidgetBuilder itemBuilder;

  ///pass into if you don't wanna use the default loading indicator [VueCircularProgressIndicator]
  final WidgetBuilder? loadingIndicatorBuilder;

  ///have to pass into if [showInitialLoadingEffectItem] is true

  final double listPaddingStartAndEnd;

  final int crossAxisCount;

  final double mainAxisSpacing;

  final double crossAxisSpacing;

  final double childAspectRatio;

  final double itemPercentBeforeLoadMore;

  PaginationSliverGridView(
      {Key? key,
      required this.itemBuilder,
      required this.scrollController,
      required this.paginationController,
      this.loadingIndicatorBuilder,
      this.listPaddingStartAndEnd = 0,
      this.crossAxisCount = 2,
      this.mainAxisSpacing = 0,
      this.crossAxisSpacing = 0,
      this.childAspectRatio = 1,
      this.itemPercentBeforeLoadMore = 30})
      : assert(paginationController.limit % crossAxisCount == 0),
        super(key: key);

  // this assert make sure the load more and loading effect work well

  @override
  _PaginationSliverGridViewState createState() =>
      _PaginationSliverGridViewState();
}

class _PaginationSliverGridViewState extends State<PaginationSliverGridView> {
  late Function onUpdate;

  @override
  void initState() {
    super.initState();
    widget.paginationController.addListener(() {
      setState(() {});
    });
  }

  Widget? buildItem(int index) {
    //loading items
    if (isFirstLoad) {
      return widget.loadingIndicatorBuilder?.call(context) ??
          SizedBox().appCenterProgressLoading;
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
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          childAspectRatio: widget.childAspectRatio,
          crossAxisSpacing: widget.crossAxisSpacing,
          mainAxisSpacing: widget.mainAxisSpacing),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.only(
                  top: index <= (widget.crossAxisCount - 1)
                      ? widget.listPaddingStartAndEnd
                      : 0,
                  bottom: index >= length ? widget.listPaddingStartAndEnd : 0),
              child: buildItem(index));
        },
        childCount: listLength,
      ),
    );
  }

  int get listLength {
    if (isFirstLoad) {
      return widget.crossAxisCount;
    } else {
      if ((widget.paginationController.canLoadMore)) {
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
