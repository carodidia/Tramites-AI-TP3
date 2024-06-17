import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';
import 'package:proyecto_final/core/entities/usuario.dart';
import 'package:proyecto_final/core/providers/solicitudes_providers.dart';
import 'package:proyecto_final/core/providers/user_providers.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';
import 'package:proyecto_final/core/widgets/pie_chart.dart';
import 'package:proyecto_final/core/widgets/snack_bar_widget.dart';
import 'package:proyecto_final/core/widgets/solicitudes_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String name = 'homescreen';
  const HomeScreen({super.key});

  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final scafoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _loadSolicitudes();
  }

  Future<void> _loadSolicitudes() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await ref.read(solicitudProvider.notifier).obtenerSolicitudes();
      Usuario user = ref.read(userProvider.notifier).getUserLogged();
      SnackBarWidget.show(context, "Bienvenido ${user.nombre}", Colors.green);
    } catch (e) {
      print('Error al obtener solicitudes: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Solicitud> solicitudes = ref.watch(solicitudProvider);
    List<Solicitud> solicitudesSinRespuesta = solicitudes
        .where((solicitud) => solicitud.estaAprobada == null)
        .toList();
    return Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Scaffold(
                appBar: AppBar(
                  title: const Text('Inicio'),
                ),
                drawer: DrawerMenu(scafoldKey: scafoldKey),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const PieChartWidget(),
                    const Divider(height: 30),
                    const Center(
                      child: Text(
                        'Solicitudes pendientes',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Expanded(
                      child:
                          SolicitudesList(solicitudes: solicitudesSinRespuesta),
                    ),
                  ],
                )));
  }
}
