import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/config.dart';

Future<bool> registrarUsuario(
    String nombre, String telefono, String correo, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
        'telefono': telefono,
        'correo': correo,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      print('Usuario registrado correctamente');
      return true;
    } else {
      print('Error al registrar usuario: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error de conexión: $e');
    return false;
  }
}
