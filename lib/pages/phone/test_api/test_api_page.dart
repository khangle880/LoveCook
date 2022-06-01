import 'package:flutter/material.dart';
import 'package:lovecook/pages/phone/test_api/test_api_bloc.dart';

import '../../../core/base/base_state.dart';

class TestApiPage extends StatefulWidget {
  final TestApiBloc bloc;

  const TestApiPage(this.bloc);

  @override
  State<TestApiPage> createState() => _TestApiPageState();
}

class _TestApiPageState extends BaseState<TestApiPage, TestApiBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Api"),
      ),
      body: Column(
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
    );
  }

  @override
  TestApiBloc get bloc => widget.bloc;
}
