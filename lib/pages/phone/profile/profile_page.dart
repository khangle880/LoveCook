import 'package:flutter/material.dart';

import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  final ProfileBloc bloc;

  const ProfilePage(this.bloc);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseState<ProfilePage, ProfileBloc> {
  @override
  void initState() {
    super.initState();
    bloc.checkProfile();
  }

  @override
  bool get isCustomLayout => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ProfileStackBackground(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ProfileCard(),
              shrinkWrap: true,
              itemCount: 6,
            )
          ],
        ),
      ),
    );
  }

  @override
  ProfileBloc get bloc => widget.bloc;
}
