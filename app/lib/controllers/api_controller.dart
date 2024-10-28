// lib/services/api_controller.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/config.dart';

class ApiController {
  final String apiUrl = '$baseUrl/usuarios';

  Future<void> registrarUsuario(
      String nombre, String telefono, String correo, String password) async {
    final url = Uri.parse(apiUrl);

    try {
      final response = await http.post(
        url,
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
      } else {
        print('Error al registrar usuario: ${response.body}');
        throw Exception('Error al registrar usuario');
      }
    } catch (e) {
      print('Excepción capturada: $e');
      rethrow;
    }
  }
}
