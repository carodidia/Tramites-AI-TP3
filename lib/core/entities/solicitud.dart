import 'package:cloud_firestore/cloud_firestore.dart';

class Solicitud {
  String id;
  String mail;
  String asunto;
  DateTime fechaCreacion;
  String mensaje;
  String respuestaIA;
  bool? estaAprobada;
  List<String> files;

  Solicitud(
      {required this.id,
      required this.mail,
      required this.asunto,
      required this.fechaCreacion,
      required this.mensaje,
      required this.respuestaIA,
      this.estaAprobada,
      required this.files});

  factory Solicitud.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Solicitud(
      id: data?['id'],
      mail: data?['mail'],
      asunto: data?['asunto'],
      fechaCreacion: (data?['fechaCreacion'] as Timestamp?)!
          .toDate(), // Conversión de Timestamp a DateTime
      mensaje: data?['mensaje'],
      respuestaIA: data?['respuestaIA'],
      estaAprobada: data?['estaAprobada'],
      files: (data?['files'] as List<dynamic>)
          .cast<String>(), // Convertir a List<String>
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "mail": mail,
      "asunto": asunto,
      "fechaCreacion": Timestamp.fromDate(
          fechaCreacion), // Conversión de DateTime a Timestamp
      "mensaje": mensaje,
      "respuestaIA": respuestaIA,
      "estaAprobada": estaAprobada,
      "files": files,
    };
  }

  @override
  String toString() {
    return 'Solicitud{id: $id, /* otros campos/}';
  }
}
