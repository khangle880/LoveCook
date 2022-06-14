import 'package:flutter/material.dart';

import '../../extensions/text_style.dart';
import '../../resources/colors.dart';
import '../../router/router.dart';
import '../widgets.dart';
import '../../data/data.dart';

class ProfileBottom extends StatefulWidget {
  final User user;
  final Function(String)? changeName;
  final Function(String)? changePhone;
  final Function(String)? changeLanguage;
  final Function(String)? changeAvatar;
  final bool isMe;

  ProfileBottom(
      {Key? key,
      required this.user,
      this.changeName,
      this.changeLanguage,
      this.changeAvatar,
      this.changePhone,
      required this.isMe})
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
          color: AppColors.successLight,
          width: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Routes.recipes,
                      arguments: _user);
                },
                title: Center(
                    child: _user != null
                        ? _user?.totalRecipes
                            .toString()
                            .s20w700(color: Color(0xFF646FD4))
                        : '0'.s20w700(color: Color(0xFF646FD4))),
                subtitle: Center(child: Text('Recipes')),
              ),
              SizedBox(height: 40.0),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Routes.posts, arguments: _user);
                },
                title: Center(
                    child: _user != null
                        ? _user!.totalPosts!
                            .toString()
                            .s20w700(color: Color(0xFF646FD4))
                        : '0'.s20w700(color: Color(0xFF646FD4))),
                subtitle: Center(child: Text('Posts')),
              ),
              SizedBox(height: 40.0),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Routes.products,
                      arguments: _user);
                },
                title: Center(
                    child: _user != null
                        ? _user!.totalProducts!
                            .toString()
                            .s20w700(color: Color(0xFF646FD4))
                        : '0'.s20w700(color: Color(0xFF646FD4))),
                subtitle: Center(child: Text('Products')),
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
                trailing: !widget.isMe
                    ? null
                    : IconButton(
                        icon: Icon(Icons.edit_note),
                        onPressed: () {
                          ShowCustomBottomSheet.changeName(context, changeName);
                        },
                      ),
                // trailing: Icon(Icons.edit_note),
              ),
              ListTile(
                title: Text("Phone"),
                subtitle:
                    Text(_user != null ? _user!.phone ?? "xxx.xxx.xxx" : ''),
                trailing: !widget.isMe
                    ? null
                    : IconButton(
                        icon: Icon(Icons.edit_note),
                        onPressed: () {
                          ShowCustomBottomSheet.changePhone(
                              context, changePhone);
                        },
                      ),
              ),
              ListTile(
                title: Text("Language"),
                subtitle: Text(
                    _user != null ? _user!.languageSetting!.toString() : ''),
                trailing: !widget.isMe
                    ? null
                    : IconButton(
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
