import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_realtime/pages/login_page.dart';
import 'package:chat_realtime/pages/usuarios_page.dart';
import 'package:chat_realtime/services/auth_service.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: checkingLogInState(context),
          builder: (context, snapshot) {
            return Center(
              child: Text("Autenticando..."),
            );
          },
        ),
      ),
    );
  }

  Future checkingLogInState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      //conectar al socket server
      // Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context, PageRouteBuilder(pageBuilder: (_, __, ___) => UsuariosPage()));
    } else {
      // Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
          context, PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage()));
    }
  }
}
