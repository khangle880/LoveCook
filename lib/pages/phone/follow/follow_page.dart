import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lovecook/blocs/follow/follow_bloc.dart';
import 'package:lovecook/data/data.dart';
import 'package:lovecook/extensions/extensions.dart';
import 'package:lovecook/resources/colors.dart';

import '../../../blocs/follow/follow.dart';
import '../../../core/base/base_state.dart';
import '../../../gen/assets.gen.dart';
import '../../../widgets/widgets.dart';

class FollowPage extends StatefulWidget {
  final FollowBloc bloc;
  const FollowPage(this.bloc);

  @override
  State<FollowPage> createState() => _FollowPageState();
}

class _FollowPageState extends BaseState<FollowPage, FollowBloc> {
  @override
  void onReceivePayload(Object? payload) {
    super.onReceivePayload(payload);
    log(payload.toString());
    if (payload is User) {
      bloc.setUserId(payload);
      getFollowers(payload.id!);
      getFollowings(payload.id!);
      bloc.follwerPagiHelper?.run();
      bloc.followingPagiHelper?.run();
    }
  }

  getFollowers(String userId) {
    bloc.follwerPagiHelper = PaginationHelper(asyncTask: (config) {
      return bloc.getFollowers(userId: userId, page: config.page).then((value) {
        config.canLoadMore = value.pagination.canLoadMore;
        config.page = value.pagination.page;
        return value.items;
      }).catchError((e) => throw e);
    }, onRefresh: () {
      setState(() {});
      bloc.follwerPagiHelper!.run();
    });
  }

  getFollowings(String userId) {
    bloc.followingPagiHelper = PaginationHelper(asyncTask: (config) {
      return bloc
          .getFollowings(userId: userId, page: config.page)
          .then((value) {
        config.canLoadMore = value.pagination.canLoadMore;
        config.page = value.pagination.page;
        return value.items;
      }).catchError((e) => throw e);
    }, onRefresh: () {
      setState(() {});
      bloc.followingPagiHelper!.run();
    });
  }

  @override
  bool get isCustomLayout => true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(text: 'Following'),
            Tab(text: 'Follower'),
          ]),
        ),
        body: StreamBuilder<FollowState>(
          stream: bloc.stateStream,
          builder: ((context, snapshot) {
            if (!snapshot.hasData || snapshot.data?.loggedUser == null)
              return Center(
                child: CircularProgressIndicator(),
              );
            final state = snapshot.data!;
            log(state.loggedUser!.followingUsers.toString());
            return TabBarView(
              children: [
                PaginationListView(
                  emptyBuilder: (_) => buildEmptyView(),
                  itemBuilder: (BuildContext context, int index) {
                    final item = bloc.followingPagiHelper!.items[index];
                    return buildUserItem(item, state);
                  },
                  paginationController: bloc.followingPagiHelper!,
                ),
                PaginationListView(
                    emptyBuilder: (_) => buildEmptyView(),
                  itemBuilder: (BuildContext context, int index) {
                    final item = bloc.follwerPagiHelper!.items[index];
                    return buildUserItem(item, state);
                  },
                  paginationController: bloc.follwerPagiHelper!,
                ),
                // Tab 2
              ],
            );
          }),
        ),
      ),
    );
  }

  Center buildEmptyView() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 50),
          Assets.images.png.search.image(height: 150, width: 150),
          "Nothing".s16w400(),
        ],
      ),
    );
  }

  Widget buildUserItem(User item, FollowState state) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.all(5),
      child: Row(
        children: [
          item.name!.s14w500(),
          Spacer(),
          if (item.id != state.loggedUser!.id)
            FollowButton(
              initIsFollowed: state.loggedUser!.followingUsers!.contains(item.id),
              onTap: (bool follow) {
                bloc.handleFollow(item, follow);
              },
            )
        ],
      ),
    );
  }

  @override
  FollowBloc get bloc => widget.bloc;
}

class FollowButton extends StatefulWidget {
  final bool initIsFollowed;
  final Function(bool follow) onTap;
  const FollowButton({
    Key? key,
    required this.initIsFollowed,
    required this.onTap,
  }) : super(key: key);

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool isFollowed;

  @override
  void initState() {
    isFollowed = widget.initIsFollowed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor =
        isFollowed ? AppColors.secondaryNormal : AppColors.secondaryNormal;
    return InkWell(
      onTap: () {
        isFollowed = !isFollowed;
        widget.onTap(isFollowed);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color: isFollowed ? AppColors.whiteLight : AppColors.secondaryNormal,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: borderColor),
        ),
        child: !isFollowed
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.white,
                  ),
                  ('  ' + 'follow').s16w500(color: AppColors.white),
                ],
              )
            : 'following'.s16w500(color: AppColors.secondaryNormal),
      ),
    );
  }
}
