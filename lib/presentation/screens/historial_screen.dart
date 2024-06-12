import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';
import 'package:proyecto_final/core/providers/solicitudes_providers.dart';
import 'package:proyecto_final/core/widgets/solicitudes_list.dart';


class HistorialScreen extends ConsumerStatefulWidget {
  static const String name = 'historialscreen';

  
  HistorialScreen({super.key});
  HistorialScreenState createState() => HistorialScreenState();
}

class HistorialScreenState extends ConsumerState<HistorialScreen>{
final scafoldKey = GlobalKey<ScaffoldState>();
@override
  void initState() {
    super.initState();
    ref.read(solicitudProvider.notifier).obtenerSolicitudes();  
  }

  @override
  Widget build(BuildContext context) {
    List<Solicitud> solicitudes = ref.watch(solicitudProvider);
    return Scaffold(
            appBar: AppBar(
              title: Text('Historial'),
            ),
            body: SolicitudesList(solicitudes: solicitudes),
          );
        }
      }
    