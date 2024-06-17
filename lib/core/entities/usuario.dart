import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String id;
  String nombre;
  String mail;
  String password;
  String detalles;

  Usuario({
    required this.id,
    required this.nombre,
    required this.mail,
    required this.password,
    required this.detalles,
  });

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Usuario(
      id: data?['id'],
      nombre: data?['nombre'],
      mail: data?['mail'],
      password: data?['password'],
      detalles: data?['detalles'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "nombre": nombre,
      "mail": mail,
      "password": password,
      "detalles": detalles,
    };
  }
  @override
  String toString() {
    return 'Usuario{id: $id, nombre: $nombre, mail: $mail, password: $password, detalles: $detalles}';
  }
}
