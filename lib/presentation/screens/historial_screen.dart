import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';
import 'package:proyecto_final/core/providers/solicitudes_providers.dart';
import 'package:proyecto_final/core/widgets/solicitudes_list.dart';

class HistorialScreen extends ConsumerStatefulWidget {
  static const String name = 'historialscreen';

  const HistorialScreen({super.key});
  @override
  HistorialScreenState createState() => HistorialScreenState();
}

class HistorialScreenState extends ConsumerState<HistorialScreen> {
  final scafoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    ref.read(solicitudProvider.notifier).obtenerSolicitudes();
  }

  @override
  Widget build(BuildContext context) {
    List<Solicitud> solicitudes = ref.watch(solicitudProvider);
    solicitudes = solicitudes
        .where((solicitud) => solicitud.estaAprobada != null)
        .toList();
    solicitudes.sort((a, b) => b.fechaCreacion.compareTo(a.fechaCreacion));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
      ),
      body: SolicitudesList(solicitudes: solicitudes),
    );
  }
}
