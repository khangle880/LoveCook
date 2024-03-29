import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../blocs/blocs.dart';
import '../../../widgets/widgets.dart';
import '../phone.dart';

class HomePage extends StatefulWidget {
  final FeedBloc feedBloc;
  final ChatBloc chatBloc;
  final ProfileBloc profileBloc;
  final RecipeBloc recipeBloc;
  final ProductBloc productBloc;
  final SharedPreferences sharedPreferences;

  const HomePage(
    this.feedBloc,
    this.chatBloc,
    this.profileBloc,
    this.recipeBloc,
    this.sharedPreferences,
    this.productBloc,
  );

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
      FeedPage(widget.feedBloc, widget.sharedPreferences),
      RecipePage(widget.recipeBloc),
      ChatPage(widget.chatBloc),
      ProductPage(widget.productBloc),
      ProfilePage(widget.profileBloc, widget.sharedPreferences),
    ];
    _icons = const [
      Icons.home,
      MdiIcons.foodForkDrink,
      MdiIcons.forumOutline,
      MdiIcons.store,
      Icons.menu,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        backgroundColor: Color(0xFFF2EBE9),
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
