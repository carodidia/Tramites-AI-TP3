import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';
import 'package:proyecto_final/core/providers/solicitudes_providers.dart';

class PieChartWidget extends ConsumerStatefulWidget {
  const PieChartWidget({super.key,});
  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
 
  
}

class _PieChartWidgetState extends ConsumerState<PieChartWidget> {
  Map<String, double> dataMap = {};
  
  final colorList = <Color>[
    const Color(0xFF299303),
    const Color(0xFFC40D0D),
    const Color(0xFFEFCA11),
  ];

  @override
  void initState() {
    super.initState();
    ref.read(solicitudProvider.notifier).obtenerSolicitudes();
    
  }

  @override
  Widget build(BuildContext context) {
    List<Solicitud> solicitudes =  ref.watch(solicitudProvider);
    dataMap = {
      "Aprobadas": solicitudes.where((solicitud) => solicitud.estaAprobada == true).length.toDouble(),
      "Rechazadas": solicitudes.where((solicitud) => solicitud.estaAprobada == false).length.toDouble(),
      "Sin Respuesta": solicitudes.where((solicitud) => solicitud.estaAprobada == null).length.toDouble(),
    };
    return PieChart(
      dataMap: dataMap,
      chartType: ChartType.disc,
      chartLegendSpacing: 48,
      colorList: colorList,
      ringStrokeWidth: 20.0,
      legendOptions: const LegendOptions(),
      chartValuesOptions: const ChartValuesOptions(),
      emptyColor: Colors.grey,
      emptyColorGradient: const [Colors.black26, Colors.black54],
      legendLabels: const {},
      degreeOptions: const DegreeOptions(),
      baseChartColor: Colors.transparent,
    );
  }
}
