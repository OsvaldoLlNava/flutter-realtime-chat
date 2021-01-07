import 'package:chat_realtime/pages/chat_page.dart';
import 'package:chat_realtime/pages/loading_page.dart';
import 'package:chat_realtime/pages/login_page.dart';
import 'package:chat_realtime/pages/register_page.dart';
import 'package:chat_realtime/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage()
};
