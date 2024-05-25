import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';
import 'package:proyecto_final/core/widgets/snack_bar_widget.dart';

class FormularioScreen extends StatefulWidget {
  static const String name = 'formularioscreen';
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario'),
      ),
      body: FormularioBody(),
      drawer: const DrawerMenu(),
    );
  }
}

class FormularioBody extends StatelessWidget {
  FormularioBody({super.key});
  final GlobalKey<FormState> _formularioEstado = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final asuntoController = TextEditingController();
  final mensajeController = TextEditingController();
//ABRIR DIALOG DEL MENSAJE
  void _showMessageDialog(BuildContext context, Map<String, dynamic> formData) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Confirmar formulario'),
              content: const Text('¿Estas seguro de enviar este formulario?'),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop(); //Cierra el dialog al apretar el boton
                    },
                    child: const Text('Cancel')),
                FilledButton(
                    onPressed: () {
                      context.go('/');
                      SnackBarWidget.show(context, "Formulario enviado", Colors.green);
                      print("Formulario enviado \n$formData");
                    },
                    child: const Text('Confirmar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formularioEstado,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (!value!.contains("@")) {
                          return "Ingrese un email valido.";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: asuntoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo no puede ser vacío";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Asunto',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: mensajeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Este campo no puede ser vacío";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Mensaje',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Acción para adjuntar archivos (no funcional por ahora)
                      },
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Adjuntar archivos'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FilledButton(
              onPressed: () {
                // Acción al presionar el botón de enviar
                if (_formularioEstado.currentState!.validate()) {
                  final formData = {
                    'id': '312',
                    'mail': emailController.text,
                    'asunto': asuntoController.text,
                    'mensaje': mensajeController.text,
                    'fechaDeCreacion': DateTime.now()
                        .toIso8601String(), // Convertir DateTime a cadena
                    'respuesta': 'Rechazado por AI',
                  };
                  _showMessageDialog(context, formData);
                }
              },
              child: const Text('Enviar'),
            ),
          ),
        ],
      ),
    );
  }
}
