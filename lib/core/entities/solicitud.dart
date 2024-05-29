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

}
