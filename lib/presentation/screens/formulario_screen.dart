import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final/core/widgets/drawer_menu.dart';
import 'package:proyecto_final/core/widgets/snack_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormularioScreen extends StatefulWidget {
  static const String name = 'formularioscreen';
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final scafoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario'),
      ),
      body: const FormularioBody(),
      drawer: DrawerMenu(scafoldKey: scafoldKey),
    );
  }
}

class FormularioBody extends StatefulWidget {
  const FormularioBody({super.key});

  @override
  State<FormularioBody> createState() => _FormularioBodyState();
}

class _FormularioBodyState extends State<FormularioBody> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formularioEstado = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final asuntoController = TextEditingController();

  final mensajeController = TextEditingController();

  String respuestaIA = 'Rechazada por AI';
  bool _isLoading = false;


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
                      context.pop(); //Cierra el dialog al apretar el boton
                      setState(() {
                        _isLoading = true;
                      });
                      try{
                        final doc = db.collection("solicitudes").doc();
                        final newSolicitud = {
                          ...formData, // Propagamos todos los datos de formData
                          'id': doc.id,
                        };
                        doc.set(newSolicitud);
                        SnackBarWidget.show(context, "Formulario enviado", Colors.green);
                      }catch (e) {
                        SnackBarWidget.show(context, "Error al enviar la solicitud", Colors.red);
                      }finally{
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.of(context).pop();
                      }
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
          //FORMULARIOO
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
                        if (value == null || !value.contains("@")) {
                          return "Ingrese un email válido.";
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

                    const Text('Simulación respuesta IA:'),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text(
                              'Rechazada por AI',
                              style: TextStyle(fontSize: 12),
                            ),
                            value: 'Rechazada por AI',
                            groupValue: respuestaIA,
                            onChanged: (value) {
                              setState(() {
                                respuestaIA = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text(
                              'Aprobada por AI',
                              style: TextStyle(fontSize: 12),
                            ),
                            value: 'Aprobada por AI',
                            groupValue: respuestaIA,
                            onChanged: (value) {
                              setState(() {
                                respuestaIA = value!;
                              });
                            },
                          ),
                        ),
                      ],
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

          //BOTON ENVIAR
          Align(
            alignment: Alignment.bottomCenter,
            child: _isLoading
                ? const CircularProgressIndicator()
                : FilledButton(
                    onPressed: () {
                      // Crea la solicitud al "Enviar"
                      if (_formularioEstado.currentState!.validate()) {
                        _formularioEstado.currentState!.save();
                        final formData = {
                          'id': '',
                          'mail': emailController.text,
                          'asunto': asuntoController.text,
                          'mensaje': mensajeController.text,
                          'fechaCreacion': Timestamp.now(),
                          'respuestaIA': respuestaIA,
                          'estaAprobada': null,
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