import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final/core/entities/usuario.dart';
import 'package:proyecto_final/core/providers/user_providers.dart';
import 'package:proyecto_final/core/widgets/snack_bar_widget.dart';
import 'package:proyecto_final/presentation/screens/add_user_screen.dart';
import 'package:proyecto_final/presentation/screens/home_screen.dart';

class LogInScreen extends StatefulWidget {
  static const String name = 'loginscreen';
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _LoginView(),
    );
  }
}

class _LoginView extends ConsumerStatefulWidget {
  const _LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<_LoginView> {
  final GlobalKey<FormState> _formularioEstado = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _datosIncorrectos = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Trámites AI',
                  style: TextStyle(
                    fontSize: 50, // Tamaño de fuente grande para el título
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .primaryColor, // Utiliza el color primario del tema
                  ),
                ),
                const SizedBox(
                    height: 32), // Espacio entre el título y los otros widgets
                const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 24, // Tamaño de fuente grande para el título
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                    height: 32), // Espacio entre el título y los otros widgets
                Form(
                    key: _formularioEstado,
                    child: Column(
                        children: [
                          TextFormField(
                            controller: _mailController,
                            validator: (value) {
                              if (value == null || !value.contains("@")) {
                                return "Ingrese un email válido.";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: !_passwordVisible,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Este campo no puede estar vacío.";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
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
                        ])),

                const SizedBox(height: 10),
                _datosIncorrectos
                    ? const Text(
                        'Usuario o contraseña incorrectos',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    : _isLoading
                        ? const CircularProgressIndicator()
                        : const SizedBox.shrink(),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      logear();
                    },
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.tonal(
                    onPressed: () {
                      context.pushNamed(AddUserScreen.name);
                    },
                    child: const Text('Registrar'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            )));
  }

  void logear() async {
    if (_formularioEstado.currentState!.validate()) {
      _formularioEstado.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
          _datosIncorrectos = false;
        });
        await ref
            .read(userProvider.notifier)
            .getUser(_mailController.text, _passwordController.text);
        if (ref.read(userProvider.notifier).isLoggedIn()) {
          print("Logeado");
          setState(() {
            _datosIncorrectos = false;
          });
          context.pushNamed(HomeScreen.name);
        } else {
          print("No logeado");
          setState(() {
            _datosIncorrectos = true;
          });
        }
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
