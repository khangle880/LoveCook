import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../blocs/blocs.dart';
import '../../../widgets/widgets.dart';
import '../phone.dart';

class HomePage extends StatefulWidget {
  final ChatBloc chatBloc;
  final ProfileBloc profileBloc;
  final SharedPreferences sharedPreferences;

  const HomePage(this.chatBloc, this.profileBloc, this.sharedPreferences);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> _screens;
  late List<IconData> _icons;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _screens = [
      Scaffold(),
      Scaffold(),
      ChatPage(widget.chatBloc),
      Scaffold(),
      ProfilePage(widget.profileBloc, widget.sharedPreferences),
    ];
    _icons = const [
      Icons.home,
      MdiIcons.foodForkDrink,
      MdiIcons.forumOutline,
      MdiIcons.bellOutline,
      Icons.menu,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 12.0),
          color: Colors.white,
          child: TopaTabBar(
            icons: _icons,
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        ),
      ),
    );
  }
}
