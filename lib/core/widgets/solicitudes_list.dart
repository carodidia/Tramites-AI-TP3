import 'package:flutter/material.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';

class SolicitudesList extends StatelessWidget {
  final List<Solicitud> solicitudes;
  const SolicitudesList({
    super.key, required this.solicitudes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: solicitudes.length,
      itemBuilder: (context, index) {
        final solicitud = solicitudes[index];
        return _CustomListTile(solicitud: solicitud);
      },
    );
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

    if(solicitud.estaAprobada == null){
      iconData = Icons.error_outline_rounded;
      color = const Color(0xFFEFCA11);
    } else if(solicitud.estaAprobada == false){
      iconData = Icons.close;
      color =const Color(0xFFC40D0D);
    }else{
      iconData = Icons.done_all_outlined;
      color = const Color(0xFF299303);
    }

    return Column(
      children: [
        ListTile(
          leading: Icon(
            iconData,
            color: color,
          ),
          title: Text("Solicitud ID: ${solicitud.id}"),
          subtitle: Text("Asunto: ${solicitud.asunto}"),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: (){
            
          },
        ),
        const Divider(
          thickness: 1.0,
        ),
      ],
    );
  }
}