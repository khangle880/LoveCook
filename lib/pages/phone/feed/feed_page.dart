import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../blocs/feed/feed.dart';
import '../../../core/base/base_response.dart';
import '../../../core/base/base_state.dart';
import '../../../data/data.dart';
import '../../../extensions/extensions.dart';
import '../../../gen/assets.gen.dart';
import '../../../router/route_arguments.dart';
import '../../../router/router.dart';
import '../../../widgets/pagination_widget/pagination_helper.dart';
import '../../../widgets/pagination_widget/pagination_sliver_listview.dart';
import '../../../widgets/post_package/post_package.dart';
import '../../../widgets/textfield_package/search_textfield.dart';
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
  late TextEditingController _searchController;
  User? get user => widget.sharedPreferences.user;

  @override
  bool get isCustomLayout => true;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

    setState(() {});
    return bloc.postPagination?.run();
  }

  Future<PagingListResponse> asyncTask(PaginationConfig config) {
    return bloc.getPosts(page: config.page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchTextField(
          controller: _searchController,
          onSubmitted: (value) {
            bloc.updateQuery(value);
            getPost();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        color: Theme.of(context).primaryColor,
        onRefresh: () async {
          setState(() {});
          bloc.postPagination?.refresh();
        },
        edgeOffset: 80,
        child: CustomScrollView(
          slivers: <Widget>[
            FeedSliverAppBar(
              userInfor: user,
              isHomeFeed: bloc.state?.user == null ? true : false,
              onPostCall: (content, listImagePath, videoPath) {
                bloc.createPost(content, listImagePath, videoPath);
              },
            ),
            PaginationSliverListView(
              emptyBuilder: (_) => Center(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Assets.images.png.search.image(height: 150, width: 150),
                    "Nothing".s16w400(),
                  ],
                ),
              ),
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
                  onReactChange: (value) {
                    bloc.reactPost(bloc.postPagination!.items[index].id, value);
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
      ),
    );
  }

  @override
  FeedBloc get bloc => widget.bloc;
}
