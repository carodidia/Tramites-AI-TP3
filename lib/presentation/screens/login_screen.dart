import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return Scaffold(
      body: _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {

  _LoginView({
    super.key,
  });

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Text(
              'Iniciar Sesión',
              style: TextStyle(
                fontSize: 24, // Tamaño de fuente grande para el título
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32), // Espacio entre el título y los otros widgets
            TextFormField(
            controller: _usernameController,
            validator: (value) {
              if (value == null || !value.contains("@")) {
                return "Ingrese un email válido.";
                } else {
                  return null;
                  }
                  },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
            hintText: 'Username',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(controller: _passwordController,
          decoration: const InputDecoration(
            hintText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context.pushNamed(HomeScreen.name, extra: _usernameController.text);
          },
          child: const Text('Login'),
        ),
          ],
        )
      )
    );
  }
}