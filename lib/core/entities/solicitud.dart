class Solicitud {
  String id;
  String mail;
  String asunto;
  DateTime fechaDeCreacion;
  String mensaje;
  String respuesta;
  bool? estaAprobada;

  Solicitud({
    required this.id,
    required this.mail,
    required this.asunto,
    required this.fechaDeCreacion,
    required this.mensaje,
    required this.respuesta,
    this.estaAprobada,
  });

}
