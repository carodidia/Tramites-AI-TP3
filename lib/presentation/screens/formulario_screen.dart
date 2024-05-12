import 'package:flutter/material.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';

class FormularioScreen extends StatelessWidget {
  static const String name = 'formularioscreen';
  const FormularioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
        ),
        body: Placeholder(),
        drawer: DrawerMenu(),
    );
  }
}