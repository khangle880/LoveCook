import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lovecook/core/base/base_response.dart';
import 'package:lovecook/widgets/pagination_widget/pagination_helper.dart';
import 'package:lovecook/widgets/pagination_widget/pagination_listview.dart';

import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../extensions/extensions.dart';
import '../../../router/route_arguments.dart';
import '../../../utils/utils.dart';
import '../../../widgets/chat_package/chat_package.dart';
import '../../../widgets/pick_media/video_widget.dart';
import '../../../widgets/post_package/post_package.dart';
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
                  post.photoUrls != null && post.photoUrls!.isNotEmpty
                      ? _buildImageSlider()
                      : const SizedBox.shrink(),
                  post.videoUrl != null && post.videoUrl!.isNotEmpty
                      ? _buildVideoSlider()
                      : const SizedBox.shrink(),
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

  CarouselSlider _buildImageSlider() {
    return CarouselSlider(
      options: CarouselOptions(height: 280.0),
      items: post.photoUrls!.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.transparent),
                child: Image(
                    image: CachedNetworkImageProvider(
                  AppConfig.instance.formatLink(imageUrl),
                )));
          },
        );
      }).toList(),
    );
  }

  CarouselSlider _buildVideoSlider() {
    return CarouselSlider(
      options: CarouselOptions(height: 300.0, enableInfiniteScroll: false),
      items: [VideoWidget(path: AppConfig.instance.formatLink(post.videoUrl!))],
    );
  }
}
