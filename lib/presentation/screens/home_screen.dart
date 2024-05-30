import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';
import 'package:proyecto_final/core/widgets/pie_chart.dart';
import 'package:proyecto_final/core/widgets/solicitudes_list.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'homescreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scafoldKey = GlobalKey<ScaffoldState>();
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Solicitud>> fetchSolicitudes() async {
    QuerySnapshot snapshot = await db.collection('solicitudes').get();
    return snapshot.docs.map((doc) {
      return Solicitud.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Future<Map<String, List<Solicitud>>> fetchAllSolicitudes() async {
    List<Solicitud> todasLasSolicitudes = await fetchSolicitudes();
    List<Solicitud> solicitudesSinRespuesta = todasLasSolicitudes
        .where((solicitud) => solicitud.estaAprobada == null)
        .toList();

    return {
      'todasLasSolicitudes': todasLasSolicitudes,
      'solicitudesSinRespuesta': solicitudesSinRespuesta,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inicio'),
        ),
        body: FutureBuilder<Map<String, List<Solicitud>>>(
          future: fetchAllSolicitudes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No hay datos'));
            } else {
              List<Solicitud> todasLasSolicitudes = snapshot.data!['todasLasSolicitudes']!;
              List<Solicitud> solicitudesSinRespuesta = snapshot.data!['solicitudesSinRespuesta']!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PieChartWidget(solicitudes: todasLasSolicitudes),
                  const Divider(height: 30),
                  const Center(
                    child: Text(
                      'Solicitudes pendientes',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Expanded(
                    child: SolicitudesList(solicitudes: solicitudesSinRespuesta),
                  ),
                ],
              );
            }
          },
        ),
        drawer: DrawerMenu(scafoldKey: scafoldKey),
      ),
    );
  }
}
