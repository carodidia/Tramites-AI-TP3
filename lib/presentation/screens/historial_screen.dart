import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';
import 'package:proyecto_final/core/widgets/solicitudes_list.dart';
import 'package:proyecto_final/core/repo/solicitudes.dart';

class HistorialScreen extends StatelessWidget {
  static const String name = 'historialscreen';

  final scafoldKey = GlobalKey<ScaffoldState>();
  HistorialScreen({super.key});
  FirebaseFirestore db = FirebaseFirestore.instance;

  // final List<Solicitud> list = solicitudes.where((solicitud)=> solicitud.estaAprobada == null).toList();
  Future<List<Solicitud>> fetchSolicitudes() async {
    QuerySnapshot snapshot = await db
        .collection('solicitudes')
        .where('estaAprobada', isNull: false)
        .get();
    return snapshot.docs.map((doc) {
      return Solicitud.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Solicitud>>(
      future: fetchSolicitudes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Solicitud> solicitudes = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Historial'),
            ),
            body: SolicitudesList(solicitudes: solicitudes),
            drawer: DrawerMenu(scafoldKey: scafoldKey),
          );
        }
      },
    );
  }
}
