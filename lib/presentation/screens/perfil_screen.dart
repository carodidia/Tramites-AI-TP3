import 'package:flutter/material.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';

class PerfilScreen extends StatelessWidget {
  static const String name = 'perfilscreen';
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        ),
        body: Placeholder(),
        drawer: DrawerMenu(),
    );
  }
}