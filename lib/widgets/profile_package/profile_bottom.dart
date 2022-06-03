import 'package:flutter/material.dart';
import 'package:lovecook/extensions/text_style.dart';

import '../../data/data.dart';

class ProfileBottom extends StatefulWidget {
  User? user;

 ProfileBottom({Key? key, this.user}) : super(key: key);

  @override
  State<ProfileBottom> createState() => _ProfileBottomState();
}

class _ProfileBottomState extends State<ProfileBottom> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    // print(widget.user?.name);
    _user = widget.user;
  }

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
              // TODO Handle Number here
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
              // TODO Handle user infor here
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
                trailing: Icon(Icons.edit_note),
              ),
              ListTile(
                title: Text("Phone"),
                subtitle: Text(_user != null ? _user!.phone! : ''),
                trailing: Icon(Icons.edit_note),
              ),
              ListTile(
                title: Text("Language"),
                subtitle:
                    Text(_user != null ? _user!.language!.toString() : ''),
                trailing: Icon(Icons.edit_note),
              ),
              // ProfileCard(icon: Icons.abc, title: 'title', content: 'content'),
              // ProfileCard(icon: Icons.abc, title: 'title', content: 'content'),
              // ProfileCard(icon: Icons.abc, title: 'title', content: 'content'),
            ],
          ),
        )
      ]),
      // height: 300,
    );
  }
}
