import 'package:flutter/material.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';
import 'package:proyecto_final/core/widgets/solicitudes_list.dart';
import 'package:proyecto_final/core/repo/solicitudes.dart';

class HistorialScreen extends StatelessWidget {
  static const String name = 'historialscreen';
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        ),
        body: SolicitudesList(solicitudes: solicitudes),
        drawer: DrawerMenu(),
    );
  }
}