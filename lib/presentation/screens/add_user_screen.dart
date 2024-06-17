import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final/core/entities/usuario.dart';
import 'package:proyecto_final/core/providers/user_providers.dart';
import 'package:proyecto_final/presentation/screens/home_screen.dart';

class AddUserScreen extends StatefulWidget {
  static const String name = 'adduserscreen';

  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registracion'),
      ),
      body: const FormularioBody(),
    );
  }
}

class FormularioBody extends ConsumerStatefulWidget {
  const FormularioBody({super.key});

  @override
  FormularioBodyState createState() => FormularioBodyState();
}

class FormularioBodyState extends ConsumerState<FormularioBody> {
  final GlobalKey<FormState> _formularioEstado = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final nombreController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isLoading = false;
  bool _emailRegistered = false;
  @override
  void initState() {
    super.initState();
  }

//ABRIR DIALOG DEL MENSAJE
  void registrar(Usuario user) async {
    setState(() {
      _isLoading = true;
    });
    try {
      bool exists = await ref.read(userProvider.notifier).isRegister(user.mail);
      print(exists);
      if (exists) {
        print("Este mail ya está registrado");
        setState(() {
          _emailRegistered = true;
        });
      } else {
        await ref.read(userProvider.notifier).addUser(user);
        print("Cuenta creada");
        context.pushNamed(
          HomeScreen.name,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(strokeWidth: 6.0),
            )
          : Column(
              children: [
                Text(
                  'Crea un nuevo usuario',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 32),
                //FORMULARIOO
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formularioEstado,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: nombreController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo no puede ser vacío";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'Nombre usuario',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: mailController,
                            validator: (value) {
                              if (value == null || !value.contains("@")) {
                                return "Ingrese un email válido.";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: UnderlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo no puede ser vacío";
                              } else {
                                return null;
                              }
                            },
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              labelText: 'contraseña',
                              border: const UnderlineInputBorder(),
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
                            controller: confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo no puede ser vacío";
                              } else if (value != passwordController.text) {
                                return "Las contaseñas no coinciden";
                              } else {
                                return null;
                              }
                            },
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              labelText: 'Confirmar contraseña',
                              border: const UnderlineInputBorder(),
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
                          const SizedBox(height: 70.0),
                          Text(
                            _emailRegistered
                                ? 'El email ingresado ya se encuentra registrado.'
                                : '',
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          FilledButton(
                            onPressed: () {
                              if (_formularioEstado.currentState!.validate()) {
                                _formularioEstado.currentState!.save();
                                final user = Usuario(
                                  id: '',
                                  nombre: nombreController.text,
                                  mail: mailController.text,
                                  password: passwordController.text,
                                  detalles: "",
                                  );
                                registrar(user);
                              }
                            },
                            child: const Text('Registrarse'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
