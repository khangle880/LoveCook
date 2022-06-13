import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../blocs/blocs.dart';
import '../../../core/base/base_response.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../extensions/extensions.dart';
import '../../../router/route_arguments.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class FeedCommentPage extends StatefulWidget {
  final FeedCommentBloc bloc;

  const FeedCommentPage(this.bloc);

  @override
  State<FeedCommentPage> createState() => _FeedCommentPageState();
}

class _FeedCommentPageState
    extends BaseState<FeedCommentPage, FeedCommentBloc> {
  late PostModel post;

  @override
  bool get isCustomLayout => true;

  @override
  FeedCommentBloc get bloc => widget.bloc;

  String comment = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void onReceivePayload(Object? payload) {
    super.onReceivePayload(payload);
    post = (payload as RouteArguments).data;
    print(post.photoUrls?.isNotEmpty);
    getComment();
  }

  getComment() {
    bloc.commentPagination = PaginationHelper(asyncTask: (config) {
      return asyncTask(config).then((value) {
        config.canLoadMore = value.pagination.canLoadMore;
        config.page = value.pagination.page;
        return (value.items as List<CommentModel>);
      }).catchError((e) => throw e);
    });

    bloc.commentPagination?.addListener(() {
      setState(() {});
    });

    return bloc.commentPagination?.run();
  }

  Future<PagingListResponse> asyncTask(PaginationConfig config) {
    return bloc.getComments(postId: post.id!, page: config.page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 2, // <-- Use this
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: PostHeader(post: post),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  (post.content ?? '').s16w600(),
                  post.photoUrls != null && post.photoUrls!.isNotEmpty
                      ? const SizedBox(height: 10.0)
                      : const SizedBox.shrink(),
                  MediaSliderWidget(
                    videoPath: post.videoUrl,
                    photoPaths: post.photoUrls,
                  ),
                  Divider(
                    height: 4.0,
                    thickness: 2,
                  ),
                ]),
          ),
          // Divider(
          //   height: 4.0,
          //   thickness: 3,
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: PaginationListView(
                  paginationController: bloc.commentPagination!,
                  itemBuilder: (BuildContext context, int index) {
                    return CommentContainer(
                      comment: bloc.commentPagination?.items[index],
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: ChatInputField(
              onChanged: (value) {
                comment = value;
              },
              onPressed: () {
                bloc.postComment(postId: post.id!, comment: comment);
              },
            ),
          )
        ],
      ),
    );
  }
}
