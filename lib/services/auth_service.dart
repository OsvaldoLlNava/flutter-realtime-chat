import 'dart:convert';
import 'package:chat_realtime/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_realtime/global/enviroment.dart';
import 'package:chat_realtime/models/login_response.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  Future login(String email, String password) async {

    this.autenticando = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(
      '${Enviroment.apiUrl}/login',
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);

      this.usuario = loginResponse.usuario;
    }

    print(resp.body);




    this.autenticando = false;
  }
}
