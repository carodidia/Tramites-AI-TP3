import 'package:flutter/material.dart';
import 'package:proyecto_final/core/entities/usuario.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';

class PerfilScreen extends StatelessWidget {
  static const String name = 'perfilscreen';

  const PerfilScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre Completo',
                border: OutlineInputBorder(),
              ),
              initialValue: "usuario.nombre",
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              initialValue: " usuario.email",
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Detalles del Usuario',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              initialValue: "usuario.detalles",
            ),
            const SizedBox(height: 30.0),
            FilledButton(
                onPressed: () {
                  //Logica para guardar los nuevos datos del usuario
                },
                child: const Text("Guardar cambios"))
          ],
        ),
      ),
    );
  }
}
