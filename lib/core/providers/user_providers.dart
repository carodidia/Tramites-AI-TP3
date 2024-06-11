import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/core/entities/usuario.dart';

final userProvider = StateNotifierProvider<UsuarioNotifier, Usuario>(
  (ref) => UsuarioNotifier(FirebaseFirestore.instance),
);

class UsuarioNotifier extends StateNotifier<Usuario> {
  final FirebaseFirestore db;

  UsuarioNotifier(this.db)
      : super(
            Usuario(id: "", nombre: "", mail: "", password: "", detalles: ""));

  Future<void> addUser(Usuario user) async {
    final doc = db.collection('usuarios').doc();
    user.id = doc.id;
    try {
      await doc.set(user.toFirestore());
      state = user;
      print(user);
    } catch (e) {
      print(e);
    }
  }

  Future<void> actualizarUser(Usuario user) async {
    final doc = db
        .collection('usuarios')
        .withConverter(
            fromFirestore: Usuario.fromFirestore,
            toFirestore: (Usuario user, _) => user.toFirestore())
        .doc(user.id);
    try {
      await doc.set(user);
      state = user;
      print(user);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUser(String mail, String password) async {
    try {
      await db
          .collection("usuarios")
          .where("mail", isEqualTo: mail)
          .where("password", isEqualTo: password)
          .withConverter(
              fromFirestore: Usuario.fromFirestore,
              toFirestore: (Usuario user, _) => user.toFirestore())
          .get()
          .then(
        (querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            final userFinded = querySnapshot.docs.first.data();
            state = userFinded;
            print(userFinded);
          } else {
            print("No such user found.");
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
    } catch (e) {
      print(e);
    }
  }
  Future<bool> isRegister(String mail) async {
    bool isRegister = false;
    try {
      await db
          .collection("usuarios")
          .where("mail", isEqualTo: mail)
          .withConverter(
              fromFirestore: Usuario.fromFirestore,
              toFirestore: (Usuario user, _) => user.toFirestore())
          .get()
          .then(
        (querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            final userFinded = querySnapshot.docs.first.data();
            print(userFinded);
            isRegister = true;
          } else {
            print("No such user found.");
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
    } catch (e) {
      print(e);
    }
    return isRegister;
  }

  Usuario getUserLogged() {
    return state;
  }

  bool isLoggedIn() {
    return state.id.isNotEmpty;
  }

  void logOut() {
    print("USUARIO LOGOUT");
    state = Usuario(id: "", nombre: "", mail: "", password: "", detalles: "");
  }
}
