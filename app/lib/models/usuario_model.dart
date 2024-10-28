// lib/models/usuario_model.dart
class Usuario {
  final int id;
  final String nombre;
  final String telefono;
  final String correo;
  final String password;

  Usuario(
      {required this.id,
      required this.nombre,
      required this.telefono,
      required this.correo,
      required this.password});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id_usuario'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      correo: json['correo'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_usuario': id,
      'nombre': nombre,
      'telefono': telefono,
      'correo': correo,
      'password': password,
    };
  }
}
