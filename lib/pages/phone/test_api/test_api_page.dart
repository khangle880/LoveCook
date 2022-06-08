import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../core/base/base_response.dart';
import '../../../core/base/base_state.dart';
import '../../../data/data.dart';
import '../../../widgets/pagination_widget/pagination_helper.dart';
import '../../../widgets/pagination_widget/pagination_listview.dart';
import 'test_api_bloc.dart';

class TestApiPage extends StatefulWidget {
  final TestApiBloc bloc;

  const TestApiPage(this.bloc);

  @override
  State<TestApiPage> createState() => _TestApiPageState();
}

class _TestApiPageState extends BaseState<TestApiPage, TestApiBloc> {
  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  getRecipes() {
    bloc.paginationHelper = PaginationHelper(
      asyncTask: (config) {
        return asyncTask(config).then((value) {
          config.canLoadMore = value.pagination.canLoadMore;
          config.page = value.pagination.page;
          return (value.items as List<PostModel>);
        }).catchError((e) => throw e);
      },
    );
    bloc.paginationHelper?.addListener(() {
      log(bloc.paginationHelper!.items.length.toString());
      // cách 2 là thêm streamcontroller và addItems cho stream tại đây
      // https://github.com/khangle880/jayella/blob/master/lib/pages/feed/feed_default/following/feed_following_page.dart
      // https://github.com/khangle880/jayella/invitations
    });
    return bloc.paginationHelper?.run();
  }

  Future<PagingListResponse> asyncTask(PaginationConfig config) {
    return bloc.getPosts(page: config.page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Api"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              RaisedButton(
                child: Text('Get Recipes'),
                onPressed: () => bloc.loadRecipes(),
              ),
              RaisedButton(
                child: Text('Get Products'),
                onPressed: () => bloc.loadProducts(),
              ),
              RaisedButton(
                child: Text('Get Posts'),
                onPressed: () => bloc.loadPosts(),
              ),
            ],
          ),
          Row(
            children: [
              RaisedButton(
                child: Text('Get Comments'),
                onPressed: () => bloc.loadComments(),
              ),
              RaisedButton(
                child: Text('Get Search'),
                onPressed: () => bloc.loadSearch(),
              ),
              RaisedButton(
                child: Text('Get Post Reactions'),
                onPressed: () => bloc.loadPostReactions(),
              ),
            ],
          ),
          SizedBox(
            height: 400,
            width: 400,
            child: PaginationListView(
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 100,
                  child: Container(
                    color: Colors.amber,
                    child: Text(
                      bloc.paginationHelper!.items[index].creator?.name ??
                          "okie",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
              paginationController: bloc.paginationHelper!,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black,
                  height: 8,
                  thickness: 8,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  TestApiBloc get bloc => widget.bloc;
}
