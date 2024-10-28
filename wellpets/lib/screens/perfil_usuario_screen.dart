import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: perfilUsuario(),
    );
  }
}

class perfilUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://example.com/your_profile_image.jpg'), // Reemplaza con la URL de tu imagen
            ),
            SizedBox(height: 16),
            Text(
              'Nombre Apellido',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'correo@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Acción al pulsar el botón de editar
              },
              child: Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
