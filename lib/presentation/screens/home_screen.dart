import 'package:flutter/material.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';
import 'package:proyecto_final/core/widgets/pie_chart.dart';
import 'package:proyecto_final/core/widgets/solicitudes_list.dart';
import 'package:proyecto_final/core/repo/solicitudes.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'homescreen';
  const HomeScreen({super.key});
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
      ),
      body: 
         Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text('Grafico',
              style: TextStyle(
                fontSize: 30,
              ),),
            ),
            Container(child: const PieChartWidget()),
            const Divider(
              height: 30,
            ),
            const Center(
              child: Text(
                'Historial de Solicitudes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  )
                )
              ),
              Expanded(
              child:SolicitudesList(solicitudes:solicitudes),
             ),
          ],
        ),
       
      drawer: const DrawerMenu(),
      ),
    );
  }
}

