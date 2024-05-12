import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final/core/repo/menu_items.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  int selectedScreen = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: selectedScreen,
      onDestinationSelected: (value){
        selectedScreen = value;
        setState(() {});
        context.push(menuItems[value].link);
      },
      children: [
        ... menuItems.sublist(0,4)
        .map((item)=> NavigationDrawerDestination(
          icon: Icon(item.icon), 
          label: Text(item.title)))
          .toList(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          ... menuItems.sublist(4,6)
        .map((item)=> NavigationDrawerDestination(
          icon: Icon(item.icon), 
          label: Text(item.title)))
          .toList(),
          const Divider(),
      ],
    );
  }
}