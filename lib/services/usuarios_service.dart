import 'package:chat_realtime/models/usuarios_response.dart';
import 'package:http/http.dart' as http;

import 'package:chat_realtime/global/enviroment.dart';
import 'package:chat_realtime/models/usuario.dart';
import 'package:chat_realtime/services/auth_service.dart';

class UsuariosService{

  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get('${Enviroment.apiUrl}/usuarios', 
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;

    } catch (e) {
      return [];
    }
  }
}