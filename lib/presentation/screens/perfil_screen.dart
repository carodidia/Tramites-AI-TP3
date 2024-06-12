import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final/core/entities/usuario.dart';
import 'package:proyecto_final/core/providers/user_providers.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';
import 'package:proyecto_final/core/widgets/snack_bar_widget.dart';

class PerfilScreen extends ConsumerStatefulWidget {
  static const String name = 'perfilscreen';

  const PerfilScreen({
    super.key,
  });

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends ConsumerState<PerfilScreen> {
  final GlobalKey<FormState> _formularioEstado = GlobalKey<FormState>();

  final scafoldKey = GlobalKey<ScaffoldState>();
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _detallesController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Usuario user = ref.watch(userProvider);
    _nombreController.text = user.nombre;
    _emailController.text = user.mail;
    _passwordController.text = user.password;
    _detallesController.text = user.detalles;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _detallesController.dispose();
    super.dispose();
  }

  Future<void> _saveUserData(Usuario newUser) async {
    try {
      await ref.read(userProvider.notifier).actualizarUser(newUser);
      SnackBarWidget.show(context, "Datos guardados con éxito", Colors.green);
      context.pop();
    } catch (e) {
      print('Error al guardar los datos del usuario: $e');
      SnackBarWidget.show(context, "Error al guardar los datos", Colors.red);
      context.pop();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMessageDialog(BuildContext context, Usuario user) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Confirmar datos'),
              content:
                  const Text('¿Estas seguro de guardar estos nuevos datos?'),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Cancel')),
                FilledButton(
                    onPressed: () async {
                      context.pop();
                      setState(() {
                        _isLoading = true;
                      });
                      final newUser = Usuario(
                          id: user.id, //Estara bien esto asi?
                          nombre: _nombreController.text,
                          mail: _emailController.text,
                          password: _passwordController.text,
                          detalles: _detallesController.text,
                          files: user.files //Estara bien esto asi?
                          );
                      await _saveUserData(newUser);
                    },
                    child: const Text('Confirmar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    Usuario user = ref.read(userProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
        ),
        drawer: DrawerMenu(scafoldKey: scafoldKey),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
                key: _formularioEstado,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16.0),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _nombreController,
                      validator: (value) {
                        if (value == null || value == '') {
                          return "El campo no puede estar vacío.";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nombre Completo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null ||
                            value == '' ||
                            !value.contains("@")) {
                          return "Ingrese un email válido.";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value == '') {
                          return "El campo no puede estar vacío.";
                        } else {
                          return null;
                        }
                      },
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _detallesController,
                      decoration: const InputDecoration(
                        labelText: 'Detalles del Usuario',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 30.0),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : FilledButton(
                              onPressed: () {
                                guardarCambios(user);
                              },
                              child: const Text("Guardar cambios")),
                    ),
                  ],
                )),
          ),
        ));
  }

  void guardarCambios(Usuario user) {
    if (_formularioEstado.currentState!.validate()) {
      _formularioEstado.currentState!.save();
      _showMessageDialog(context, user);
    }
  }
}
