import 'package:chat_realtime/helpers/mostrar_alerta.dart';
import 'package:chat_realtime/services/auth_service.dart';
import 'package:chat_realtime/widgets/boton_azul.dart';
import 'package:chat_realtime/widgets/custom_input.dart';
import 'package:chat_realtime/widgets/labels.dart';
import 'package:chat_realtime/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(
                  titulo: 'Messenger',
                ),
                _Form(),
                Labels(
                  text1: 'No tienes Cuenta?',
                  text2: 'Crea una ahora!',
                  ruta: 'register',
                ),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            CustomInput(
              icon: Icons.mail_outline,
              placeholder: 'Correo',
              keywordType: TextInputType.emailAddress,
              textController: emailController,
              isPassword: false,
            ),
            CustomInput(
              icon: Icons.lock_outline,
              placeholder: 'Contraseña',
              keywordType: TextInputType.emailAddress,
              textController: passController,
              isPassword: true,
            ),
            BotonAzul(
              text: 'Ingrese',
              onPress: authService.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final loginOk = await authService.login(
                        emailController.text.trim(),
                        passController.text.trim(),
                      );

                      if (loginOk) {
                        // conectar a nuestro socket server

                        // navegar a otra pantalla
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        //mostrar alerta
                        mostrarAlerta(
                          context,
                          'Login Incorrecto',
                          'Revise sus credenciales',
                        );
                      }
                    },
            ),
          ],
        ));
  }
}
