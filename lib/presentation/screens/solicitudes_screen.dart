import 'package:flutter/material.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';
import 'package:proyecto_final/core/widgets/solicitudes_list.dart';
import 'package:proyecto_final/core/repo/solicitudes.dart';

class SolicitudesScreen extends StatelessWidget {
  static const String name = 'solicitudesScreen';
  SolicitudesScreen({super.key});

  final List<Solicitud> list = solicitudes.where((solicitud)=> solicitud.estaAprobada == null).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitudes'),
        ),
        body: SolicitudesList(solicitudes:list),
        drawer: DrawerMenu(),
    );
  }
}