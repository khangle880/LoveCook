import 'package:flutter/material.dart';

import '../../extensions/text_style.dart';
import '../widgets.dart';
import '../../data/data.dart';

class ProfileBottom extends StatefulWidget {
  final User? user;
  final Function(String)? changeName;
  final Function(String)? changePhone;
  final Function(String)? changeLanguage;
  final Function(String)? changeAvatar;

  ProfileBottom(
      {Key? key,
      this.user,
      this.changeName,
      this.changeLanguage,
      this.changeAvatar,
      this.changePhone})
      : super(key: key);

  @override
  State<ProfileBottom> createState() => _ProfileBottomState();
}

class _ProfileBottomState extends State<ProfileBottom> {
  User? get _user => widget.user;

  Function(String)? get changeName => widget.changeName;
  Function(String)? get changePhone => widget.changePhone;
  Function(String)? get changeLanguage => widget.changeLanguage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(children: [
        Container(
          color: Color(0xFFDBDFFD),
          width: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Center(
                    child: _user != null
                        ? _user!.followerUsers!.length
                            .toString()
                            .s20w700(color: Color(0xFF646FD4))
                        : '0'.s20w700(color: Color(0xFF646FD4))),
                subtitle: Center(child: Text('Followers')),
              ),
              SizedBox(height: 40.0),
              ListTile(
                title: Center(
                    child: _user != null
                        ? _user!.followingUsers!.length
                            .toString()
                            .s20w700(color: Color(0xFF646FD4))
                        : '0'.s20w700(color: Color(0xFF646FD4))),
                subtitle: Center(child: Text('Following')),
              ),
              SizedBox(height: 40.0),
              ListTile(
                title: Center(child: '40'.s20w700(color: Color(0xFF646FD4))),
                subtitle: Center(child: Text('Posts')),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              ListTile(
                title: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _user != null
                          ? _user!.name!.s20w700(color: Color(0xFF646FD4))
                          : Text(''),
                      SizedBox(width: 10.0),
                      _user != null
                          ? _user!.email!.s12w400(color: Color(0xFF52616B))
                          : Text('')
                    ]),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    _user != null ? _user!.bio! : '',
                    maxLines: 3,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text("Name"),
                subtitle: Text(_user != null ? _user!.name! : ''),
                trailing: IconButton(
                  icon: Icon(Icons.edit_note),
                  onPressed: () {
                    ShowCustomBottomSheet.changeName(context, changeName);
                  },
                ),
                // trailing: Icon(Icons.edit_note),
              ),
              ListTile(
                title: Text("Phone"),
                subtitle: Text(_user != null ? _user!.phone! : ''),
                trailing: IconButton(
                  icon: Icon(Icons.edit_note),
                  onPressed: () {
                    ShowCustomBottomSheet.changePhone(context, changePhone);
                  },
                ),
              ),
              ListTile(
                title: Text("Language"),
                subtitle: Text(
                    _user != null ? _user!.languageSetting!.toString() : ''),
                trailing: IconButton(
                  icon: Icon(Icons.edit_note),
                  onPressed: () {
                    ShowCustomBottomSheet.changeLanguage(
                        context, changeLanguage);
                  },
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
