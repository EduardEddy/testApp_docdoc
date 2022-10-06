import 'package:chat_test/src/controllers/user_ctrl.dart';
import 'package:chat_test/src/screen/login_screen.dart';
import 'package:chat_test/src/widgets/button_widget.dart';
import 'package:chat_test/src/widgets/input_widget.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final divider = const SizedBox(height: 15);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? correo, clave, nombre;

  String? edad;

  final userCtrl = UserCtrl();
  late IO.Socket _socket;

  _connectSocket() async {
    _socket = await IO.io(
      'http://192.168.10.14:3002',
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'username': 'widget.username'}).build(),
    );
    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    /*_socket.on(
      'message',
      (data) => Provider.of<HomeProvider>(context, listen: false).addNewMessage(
        Message.fromJson(data),
      ),
    );*/
  }

  void initState() {
    super.initState();
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000

    _connectSocket();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.15),
                  const Text(
                    'REGISTRATE',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  divider,
                  InputWidget(
                    label: 'Nombre',
                    onChange: (String nombre) {
                      this.nombre = nombre;
                    },
                    validator: (String? nombre) {
                      if (nombre!.trim().isEmpty) {
                        return 'El nombre es requerido';
                      }
                      return null;
                    },
                    iconLeft: const Icon(Icons.person),
                  ),
                  divider,
                  InputWidget(
                    label: 'Edad',
                    onChange: (String edad) {
                      if (edad == '') {
                        edad = '0';
                      }
                      this.edad = edad;
                    },
                    validator: (String? edad) {
                      if (edad!.trim().isEmpty) {
                        return 'La edad es requerida';
                      }
                      if (int.parse(edad) <= 0) {
                        return 'la edad debe ser un valor valido';
                      }
                      return null;
                    },
                    iconLeft: const Icon(Icons.numbers),
                    inputType: TextInputType.number,
                  ),
                  divider,
                  InputWidget(
                    label: 'Correo',
                    inputType: TextInputType.emailAddress,
                    onChange: (String correo) {
                      this.correo = correo;
                    },
                    validator: (String? correo) {
                      if (correo!.trim().isEmpty) {
                        return 'El correo es requerido';
                      }
                      if (!EmailValidator.validate(correo)) {
                        return 'Debe ingresar un correo valido';
                      }
                      return null;
                    },
                    iconLeft: const Icon(Icons.email),
                  ),
                  divider,
                  InputWidget(
                    label: 'Clave',
                    obscureText: true,
                    onChange: (String clave) {
                      this.clave = clave;
                    },
                    validator: (String? clave) {
                      if (clave!.trim().isEmpty) {
                        return 'La clave es requerido';
                      }
                      return null;
                    },
                    iconLeft: const Icon(Icons.key),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      right: 15,
                      left: 15,
                      bottom: 1,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ButtonWidget(
                        text: 'Guardar',
                        verticalPadding: 12,
                        fontSize: 18,
                        action: () async {
                          bool ok = formKey.currentState!.validate();
                          if (ok) {
                            final data = {
                              'correo': correo,
                              'clave': clave,
                              'edad': edad,
                              'nombre': nombre
                            };
                            final response = await userCtrl.post(context, data);
                            if (response != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          ),
                          child: const Text('Ya tienes cuenta'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
