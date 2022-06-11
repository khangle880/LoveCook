import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../blocs/feed/feed.dart';
import '../../../core/base/base_response.dart';
import '../../../core/base/base_state.dart';
import '../../../data/data.dart';
import '../../../extensions/extensions.dart';
import '../../../router/route_arguments.dart';
import '../../../router/router.dart';
import '../../../widgets/pagination_widget/pagination_helper.dart';
import '../../../widgets/pagination_widget/pagination_sliver_listview.dart';
import '../../../widgets/post_package/post_package.dart';
import '../../pages.dart';
import 'widgets/feed_sliver_app_bar.dart';

class FeedPage extends StatefulWidget {
  final FeedBloc bloc;
  final SharedPreferences sharedPreferences;

  const FeedPage(this.bloc, this.sharedPreferences);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends BaseState<FeedPage, FeedBloc> {
  User? get user => widget.sharedPreferences.user;

  @override
  bool get isCustomLayout => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void onReceivePayload(Object? payload) {
    super.onReceivePayload(payload);
    if (payload is User) {
      bloc.setUser(payload);
    }
    getPost();
  }

  getPost() {
    bloc.postPagination = PaginationHelper(asyncTask: (config) {
      return asyncTask(config).then((value) {
        config.canLoadMore = value.pagination.canLoadMore;
        config.page = value.pagination.page;
        return (value.items as List<PostModel>);
      }).catchError((e) => throw e);
    }, onRefresh: () {
      setState(() {});
      bloc.postPagination?.run();
    });

    bloc.postPagination?.addListener(() {
      setState(() {});
    });

    return bloc.postPagination?.run();
  }

  Future<PagingListResponse> asyncTask(PaginationConfig config) {
    return bloc.getPosts(page: config.page);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        bloc.postPagination?.refresh();
      },
      edgeOffset: 80,
      child: CustomScrollView(
        slivers: <Widget>[
          // TODO: if (state.user != null) ...
          FeedSliverAppBar(
            userInfor: user,
            onPostCall: (content, listImagePath, listVideoPath) {
              bloc.createPost(content, listImagePath, listVideoPath);
            },
          ),
          PaginationSliverListView(
            paginationController: bloc.postPagination!,
            itemBuilder: (BuildContext context, int index) {
              return PostContainer(
                post: bloc.postPagination!.items[index],
                onCommentPress: () {
                  if (bloc.postPagination?.items[index] != null)
                    Navigator.pushNamed(context, Routes.feedComment,
                        arguments: RouteArguments(
                            data: bloc.postPagination!.items[index]));
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Color(0xFFF2EBE9),
                height: 8,
                thickness: 8,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  FeedBloc get bloc => widget.bloc;
}
