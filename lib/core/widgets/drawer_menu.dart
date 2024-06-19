import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final/core/entities/usuario.dart';
import 'package:proyecto_final/core/providers/user_providers.dart';
import 'package:proyecto_final/core/repo/menu_items.dart';

class DrawerMenu extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scafoldKey;
  const DrawerMenu({super.key, required this.scafoldKey});

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends ConsumerState<DrawerMenu> {
  @override
  void initState() {
    super.initState();
    ref.read(userProvider);
  }

  int selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    Usuario user = ref.watch(userProvider);

    return NavigationDrawer(
      selectedIndex: selectedScreen,
      onDestinationSelected: (value) {
        if(value == menuItems.length - 1){
           ref.read(userProvider.notifier).logOut();
        }
        setState(() {
          selectedScreen = value;
        });
        context.push(menuItems[value].link);
        widget.scafoldKey.currentState?.closeDrawer();
      },
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context)
                .primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trámites AI',
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Bienvenido ${user.nombre}',
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        ...menuItems
            .sublist(0, 4)
            .map((item) => NavigationDrawerDestination(
                icon: Icon(item.icon), label: Text(item.title)))
            ,
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(),
        ),
        ...menuItems
            .sublist(4, 6)
            .map((item) => NavigationDrawerDestination(
                icon: Icon(item.icon), label: Text(item.title))),
      ],
    );
  }
}
