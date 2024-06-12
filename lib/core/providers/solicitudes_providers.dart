import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';

final solicitudProvider = StateNotifierProvider<SolicitudNotifier, List<Solicitud>>(
  (ref) => SolicitudNotifier(FirebaseFirestore.instance),
);

class SolicitudNotifier extends StateNotifier<List<Solicitud>> {
  final FirebaseFirestore db;

  SolicitudNotifier(this.db) : super([]);


  Future<void> agregarSolicitud(Solicitud solicitud) async {
    final doc = db.collection('solicitudes').doc();
    solicitud.id = doc.id;
    print(solicitud.toString());
    try{
      await doc.set(solicitud.toJson());
      state = [...state, solicitud];
    }catch (e){
      print(e);
    }
  }

   Future<void> obtenerSolicitudes() async {
    final docs = db.collection('solicitudes').withConverter(
        fromFirestore: Solicitud.fromFirestore,
        toFirestore: (Solicitud solicitud, _) => solicitud.toJson());
    final solicitudes = await docs.get();
    state = [...solicitudes.docs.map((d) => d.data())];
  }

  Future<void> actualizarSolicitud(String id, bool aprobada) async {
    final doc = db.collection('solicitudes').doc(id);
    try{
      await doc.update({"estaAprobada": aprobada});
      await obtenerSolicitudes();
    }catch (e){
      print(e);
    }
  }


}


