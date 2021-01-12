import 'package:chat_realtime/models/usuario.dart';
import 'package:chat_realtime/services/auth_service.dart';
import 'package:chat_realtime/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key key}) : super(key: key);

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarios = [
    // Usuario(online: false, email: 'meli@mail.com', nombre: 'Melissa', uid: '1'),
    // Usuario(online: true, email: 'andy@mail.com', nombre: 'Andrea', uid: '2'),
    // Usuario(online: false, email: 'pao@mail.com', nombre: 'Paola', uid: '3'),
    // Usuario(
    //     online: true, email: 'osvaldo@mail.com', nombre: 'Osvaldo', uid: '4'),
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final Usuario usuario = authService.usuario;
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          usuario.nombre,
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          color: Colors.black54,
          onPressed: () {
            // desconectar del socket server
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: true //Aqui colocar la condicion de si esta o no conectado
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue[300],
                  )
                : Icon(
                    Icons.offline_bolt,
                    color: Colors.red,
                  ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        child: _listViewUsuarios(),
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[400],
          ),
          waterDropColor: Colors.blue[400],
        ),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[300],
        child: Text(
          usuario.nombre.substring(0, 2),
          style: TextStyle(color: Colors.white),
        ),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
