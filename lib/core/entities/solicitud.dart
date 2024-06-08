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

  /*factory Solicitud.fromJson(Map<String, dynamic> json, String id) {
    return Solicitud(
      id: id,
      mail: json['mail'],
      asunto: json['asunto'],
      fechaCreacion: (json['fechaCreacion'] as Timestamp?)!.toDate(),
      mensaje: json['mensaje'],
      respuestaIA: json['respuestaIA'],
      estaAprobada: json['estaAprobada'],
    );
  }*/

  factory Solicitud.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Solicitud(
      id: data?['id'], // Si 'id' es null, usa una cadena vacía en su lugar
      mail: data?['mail'],
      asunto: data?['asunto'],
      fechaCreacion: (data?['fechaCreacion'] as Timestamp?)!.toDate(), // Conversión de Timestamp a DateTime
      mensaje: data?['mensaje'],
      respuestaIA: data?['respuestaIA'],
      estaAprobada: data?['estaAprobada'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mail": mail,
      "asunto": asunto,
      "fechaCreacion": fechaCreacion != null ? Timestamp.fromDate(fechaCreacion!) : null, // Conversión de DateTime a Timestamp
      "mensaje": mensaje,
      "respuestaIA": respuestaIA,
      "estaAprobada": estaAprobada,
    };
  }
  

}
