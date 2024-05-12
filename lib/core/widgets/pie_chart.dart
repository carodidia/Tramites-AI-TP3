import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:proyecto_final/core/repo/solicitudes.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({super.key});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  Map<String,double> dataMap = {
    "Aprobadas": solicitudes.where((solicitud) => solicitud.estaAprobada == true).length.toDouble(),
    "Rechazads": solicitudes.where((solicitud) => solicitud.estaAprobada == false).length.toDouble(),
    "Sin Respuesta": solicitudes.where((solicitud) => solicitud.estaAprobada == null).length.toDouble()
     };

  final colorList = <Color>[
    const Color(0xFF299303),
    const Color(0xFFC40D0D),
    const Color(0xFFEFCA11),
    
  ];

  @override
  Widget build(BuildContext context) {
    
    return PieChart(
        dataMap: dataMap,
        chartType: ChartType.disc,
        chartLegendSpacing: 48,
        colorList: colorList,
        ringStrokeWidth: 20.0,
        legendOptions: const LegendOptions(),
        chartValuesOptions:const ChartValuesOptions(),
        emptyColor:Colors.grey,
        emptyColorGradient:const [Colors.black26, Colors.black54],
        legendLabels:const {},
        degreeOptions:const DegreeOptions(),
        baseChartColor:Colors.transparent,
      
      );
    
  }
}