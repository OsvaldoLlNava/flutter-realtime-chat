// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.online,
        this.nombre,
        this.email,
        this.iud,
    });

    bool online;
    String nombre;
    String email;
    String iud;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        nombre: json["nombre"],
        email: json["email"],
        iud: json["iud"],
    );

    Map<String, dynamic> toJson() => {
        "online": online,
        "nombre": nombre,
        "email": email,
        "iud": iud,
    };
}
