import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';
import 'package:proyecto_final/presentation/screens/solicitud_screen.dart';

class SolicitudesList extends StatelessWidget {
  final List<Solicitud> solicitudes;
  const SolicitudesList({
    super.key,
    required this.solicitudes,
  });

  @override
   Widget build(BuildContext context) {
    if (solicitudes.isEmpty) {
      return const Center(
        child: Text(
          'No hay solicitudes',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: solicitudes.length,
        itemBuilder: (context, index) {
          final solicitud = solicitudes[index];
          return _CustomListTile(solicitud: solicitud);
        },
      );
    }
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    super.key,
    required this.solicitud,
  });

  final Solicitud solicitud;

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color color;

    if (solicitud.estaAprobada == null) {
      iconData = Icons.circle;
      color = const Color(0xFFEFCA11);
    } else if (solicitud.estaAprobada == false) {
      iconData = Icons.circle;
      color = const Color(0xFFC40D0D);
    } else {
      iconData = Icons.circle;
      color = const Color(0xFF299303);
    }

    return Column(
      children: [
        ListTile(
          leading: Icon(
            iconData,
            color: color,
          ),
          title: Text("Cliente: ${solicitud.mail}"),
          subtitle: Text("Asunto: ${solicitud.asunto}"),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            context.pushNamed(SolicitudScreen.name, extra: solicitud);
          },
        ),
        const Divider(
          thickness: 1.0,
        ),
      ],
    );
  }
}
