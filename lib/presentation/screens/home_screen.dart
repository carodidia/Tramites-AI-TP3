import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';
import 'package:proyecto_final/core/providers/solicitudes_providers.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';
import 'package:proyecto_final/core/widgets/pie_chart.dart';
import 'package:proyecto_final/core/widgets/solicitudes_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String name = 'homescreen';
  HomeScreen({super.key});
  
  HomeScreenState createState() => HomeScreenState();

}
  class HomeScreenState extends ConsumerState<HomeScreen>{
    final scafoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    ref.read(solicitudProvider.notifier).obtenerSolicitudes();
    
  }

  @override
  Widget build(BuildContext context) {
    List<Solicitud> solicitudes =  ref.watch(solicitudProvider);
    List<Solicitud> solicitudesSinRespuesta = solicitudes.where((solicitud)=> solicitud.estaAprobada == null).toList();
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inicio'),
          
        ),
        drawer: DrawerMenu(scafoldKey: scafoldKey),
        body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PieChartWidget(),
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
              )
      )
    );
  } 
}  
