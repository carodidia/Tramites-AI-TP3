import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';
import 'package:proyecto_final/core/providers/solicitudes_providers.dart';
import 'package:proyecto_final/core/widgets/solicitudes_list.dart';


class SolicitudesScreen extends ConsumerStatefulWidget{
  static const String name = 'solicitudesScreen';
  final scafoldKey = GlobalKey<ScaffoldState>();

  SolicitudesScreen({super.key});
  @override
  SolicitudScreenState createState() => SolicitudScreenState();

}

class SolicitudScreenState extends ConsumerState<SolicitudesScreen>{
@override
  void initState() {
    super.initState();
    ref.read(solicitudProvider.notifier).obtenerSolicitudes();
    
  }

@override
 Widget build(BuildContext context) {
    List<Solicitud> solicitudes = ref.watch(solicitudProvider);
    solicitudes = solicitudes.where((solicitud)=> solicitud.estaAprobada == null).toList();
    return Scaffold(
            appBar: AppBar(
              title: const Text('Solicitudes'),
            ),
            body: SolicitudesList(solicitudes: solicitudes),
            
          );
     }
}
  

  
 
 

