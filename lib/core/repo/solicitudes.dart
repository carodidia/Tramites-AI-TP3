import 'package:proyecto_final/core/entities/solicitud.dart';

List<Solicitud> solicitudes = [
  Solicitud(
    id: '1',
    mail: 'caro@gmail.com',
    asunto: 'Denuncia Policial',
    fechaDeCreacion: DateTime(
        2024, 6, 1, 14, 35, 21), // Día, mes, año, hora, minutos, segundos
    mensaje:
        'Quiero denunciar un choque. El incidente ocurrió el martes pasado en la intersección de Main St y Elm St. Adjunto fotos del accidente.',
    respuesta: 'Aprobado por AI',
  ),
  Solicitud(
    id: '2',
    mail: 'denu@gmail.com',
    asunto: 'Cotización',
    fechaDeCreacion: DateTime(
        2024, 6, 1, 9, 12, 45), // Día, mes, año, hora, minutos, segundos
    mensaje:
        'Quiero una cotización para reparar mi auto. El vehículo es un sedan de 4 puertas, marca XYZ, modelo 2020. El incidente ocurrió la semana pasada. Quedo a la espera de su respuesta. Saludos cordiales.',
    respuesta: 'Aprobado por AI',
    estaAprobada: true,
  ),
  Solicitud(
    id: '3',
    mail: 'ivan@gmail.com',
    asunto: 'Cotizacion de auto',
    fechaDeCreacion: DateTime(
        2024, 6, 3, 17, 5, 33), // Día, mes, año, hora, minutos, segundos
    mensaje: 'Quiero la cotizacion de este auto',
    respuesta: 'Rechazado por AI',
    estaAprobada: false,
  ),
  Solicitud(
    id: '4',
    mail: 'ari@gmail.com',
    asunto: 'Denuncia Policial',
    fechaDeCreacion: DateTime(
        2024, 6, 4, 11, 20, 15), // Día, mes, año, hora, minutos, segundos
    mensaje: 'Quiero denunciar un robo',
    respuesta: 'Aprobado por AI',
  ),
  Solicitud(
    id: '5',
    mail: 'juan@gmail.com',
    asunto: 'Cotizacion de hogar',
    fechaDeCreacion: DateTime(
        2024, 6, 5, 22, 45, 59), // Día, mes, año, hora, minutos, segundos
    mensaje: 'Quiero una cotizacion de hogar',
    respuesta: 'Rechazado por AI',
    estaAprobada: false,
  ),
  Solicitud(
    id: '6',
    mail: 'pepe@gmail.com',
    asunto: 'Denuncia Policial',
    fechaDeCreacion: DateTime(
        2024, 6, 6, 8, 30, 0), // Día, mes, año, hora, minutos, segundos
    mensaje: 'Quiero denunciar un choque',
    respuesta: 'Aprobado por AI',
  ),
  Solicitud(
    id: '7',
    mail: 'pepe@gmail.com',
    asunto: 'Denuncia Policial',
    fechaDeCreacion: DateTime(
        2024, 6, 7, 16, 15, 10), // Día, mes, año, hora, minutos, segundos
    mensaje: 'Quiero denunciar un choque',
    respuesta: 'Aprobado por AI',
    estaAprobada: true,
  ),
  Solicitud(
    id: '8',
    mail: 'pepe@gmail.com',
    asunto: 'Denuncia Policial',
    fechaDeCreacion: DateTime(
        2024, 6, 8, 10, 5, 45), // Día, mes, año, hora, minutos, segundos
    mensaje: 'Quiero denunciar un choque',
    respuesta: 'Aprobado por AI',
  ),
];
