import 'package:flutter/material.dart';
import 'screens/inicio_sesion_screen.dart'; // Importar la pantalla de inicio de sesión

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WellPets',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          LoginScreen(), // Cambia HomeScreen por LoginScreen para iniciar en inicio de sesión
    );
  }
}
