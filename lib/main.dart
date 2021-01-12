import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:chat_realtime/routes/routes.dart';
import 'package:chat_realtime/services/auth_service.dart';
import 'package:chat_realtime/services/socket_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => SocketService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChatApp',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
