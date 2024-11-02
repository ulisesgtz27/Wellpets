import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: perfil_perro(),
    );
  }
}

class perfil_perro extends StatelessWidget {
  const perfil_perro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de tu mascota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  NetworkImage('https://example.com/your_profile_image.jpg'),
            ),
            SizedBox(height: 16),
            Text(
              'Nombre mascota',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Raza',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              'Peso',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              'Edad',
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
