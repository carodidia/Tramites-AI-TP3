import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';
import 'package:proyecto_final/core/widgets/snack_bar_widget.dart';

class SolicitudScreen extends StatelessWidget {
  static const String name = 'solicitudscreen';
  final Solicitud solicitud;
  const SolicitudScreen({super.key, required this.solicitud});

  //METODO PARA FORMATEAR LA FECHA DE SOLICITUD
  String _getFormattedDate(DateTime fecha) {
    print(fecha);
    return '${fecha.day}/${(fecha.month)}/${fecha.year}';
  }

//ABRIR DIALOG DEL MENSAJE
  void _showMessageDialog(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mensaje'),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Solicitud'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.email_outlined, solicitud.mail),
            _buildInfoRow(Icons.announcement_outlined, solicitud.asunto),
            _buildInfoRow(Icons.calendar_month_outlined,
                _getFormattedDate(solicitud.fechaCreacion)),
            _buildInfoRow(Icons.person_outline, solicitud.id),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showMessageDialog(context, solicitud.mensaje);
              },
              child: const Text('Abrir mensaje'),
            ),
            const Divider(height: 32.0, thickness: 2.0),
            const Text('Respuesta de la IA:', style: TextStyle(fontSize: 18.0)),
            const SizedBox(height: 8.0),
            Text(solicitud.respuestaIA),
            const SizedBox(height: 100.0),
            Visibility(
              visible: solicitud.estaAprobada == null,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "¿Qué desea hacer con la solicitud?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          //LOGICA PARA VALIDAR O RECHAZAR LA SOLICITUD
                          SnackBarWidget.show(context,
                              'Solicitud Rechazada por el usuario', Colors.red);
                          context.pop(); //Vuelve para atras
                        },
                        child: const Text('Rechazar'),
                      ),
                      FilledButton(
                        onPressed: () {
                          //LOGICA PARA VALIDAR O RECHAZAR LA SOLICITUD
                          SnackBarWidget.show(
                              context,
                              'Solicitud Aceptada por el usuario',
                              Colors.green);
                          context.pop(); //Vuelve para atras
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: solicitud.estaAprobada != null,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          solicitud.estaAprobada ?? false
                              ? "La solicitud fue Aprobada por el usuario"
                              : "La solicitud fue Rechazada por el usuario",
                          textAlign:
                              TextAlign.center, // Alinear el texto al centro
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: solicitud.estaAprobada ?? false
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData iconData, String valorSolicitud) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(iconData, size: 24.0),
          const SizedBox(width: 20.0), // Espacio entre el icono y el texto
          Text(valorSolicitud, style: const TextStyle(fontSize: 18.0)),
        ],
      ),
    );
  }
}
