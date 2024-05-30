import 'package:cloud_firestore/cloud_firestore.dart';

class Solicitud {
  String id;
  String mail;
  String asunto;
  DateTime fechaCreacion;
  String mensaje;
  String respuestaIA;
  bool? estaAprobada;

  Solicitud({
    required this.id,
    required this.mail,
    required this.asunto,
    required this.fechaCreacion,
    required this.mensaje,
    required this.respuestaIA,
    this.estaAprobada,
  });

  factory Solicitud.fromJson(Map<String, dynamic> json, String id) {
    return Solicitud(
      id: id,
      mail: json['mail'],
      asunto: json['asunto'],
      fechaCreacion: (json['fechaCreacion'] as Timestamp?)!.toDate(),

      mensaje: json['mensaje'],
      respuestaIA: json['respuestaIA'],
      estaAprobada: json['estaAprobada'],
    );
  }
  

}
