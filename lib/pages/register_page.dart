import 'package:chat_realtime/helpers/mostrar_alerta.dart';
import 'package:chat_realtime/services/auth_service.dart';
import 'package:chat_realtime/widgets/boton_azul.dart';
import 'package:chat_realtime/widgets/custom_input.dart';
import 'package:chat_realtime/widgets/labels.dart';
import 'package:chat_realtime/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);

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
                Logo(titulo: 'Registro'),
                _Form(),
                Labels(
                  text1: 'Ya tienes una cuenta?',
                  text2: 'Ingresa!',
                  ruta: 'login',
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
  final nameController = TextEditingController();
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
              icon: Icons.perm_identity,
              placeholder: 'Nombre',
              keywordType: TextInputType.text,
              textController: nameController,
              isPassword: false,
            ),
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
              text: 'Crear Cuenta',
              onPress: authService.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final registerOk = await authService.register(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        passController.text.trim(),
                      );

                      if (registerOk == true) {
                        // conectar a nuestro socket server

                        // navegar a otra pantalla
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        //mostrar alerta
                        mostrarAlerta(
                          context,
                          'Registro Incorrecto',
                          registerOk,
                        );
                      }
                    },
            ),
            // BotonAzul(
            //   text: 'Ingrese',
            //   onPress: () {
            //     // print(nameController.text);
            //     // print(emailController.text);
            //     // print(passController.text);
            //   },
            // ),
          ],
        ));
  }
}
