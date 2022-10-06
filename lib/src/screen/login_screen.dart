import 'package:chat_test/src/controllers/login_ctrl.dart';
import 'package:chat_test/src/controllers/user_ctrl.dart';
import 'package:chat_test/src/screen/list_users_screen.dart';
import 'package:chat_test/src/screen/register_screen.dart';
import 'package:chat_test/src/widgets/button_widget.dart';
import 'package:chat_test/src/widgets/input_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final divider = const SizedBox(height: 15);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? correo;
  String? clave;
  final loginCtrl = LoginCtrl();

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
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
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
                        text: 'Entrar',
                        verticalPadding: 12,
                        fontSize: 18,
                        action: () async {
                          bool ok = formKey.currentState!.validate();
                          if (ok) {
                            final resp = await loginCtrl.login(
                              context,
                              {'correo': correo, 'clave': clave},
                            );
                            if (resp != null) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const ListUserScreen(),
                                ),
                                (Route<dynamic> route) => false,
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
                                builder: (context) => RegisterScreen()),
                          ),
                          child: const Text('Registrate'),
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
