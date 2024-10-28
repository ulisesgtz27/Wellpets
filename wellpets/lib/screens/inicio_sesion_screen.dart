import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WellPets',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Imagen superior
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo o imagen
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Image.asset(
                          'lib/assets/images/icon.png', // Ruta de tu imagen (Logo o mascotas)
                          height: 150,
                        ),
                      ),
                      Text(
                        'WellPets',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Campos de texto y botón de inicio de sesión
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.visibility_off),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => Index()),
                 );
                    },
                    child: Text('Iniciar sesión con Email'),
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.purple, // Color del botón
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('¿Olvidó su contraseña?', style: TextStyle(color: Colors.purple)),
                  SizedBox(height: 20),
                  Divider(thickness: 1, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('o Continuar con'),
                  SizedBox(height: 10),

                  // Botones de redes sociales
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.facebook),
                        color: Colors.blue,
                        onPressed: () {},
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.g_translate),
                        color: Colors.red,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      text: '¿No tiene una cuenta todavía? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Registrarse',
                          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
