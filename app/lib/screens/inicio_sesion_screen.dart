import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'registro_screen.dart'; // Importa la pantalla de registro
import 'home_screen.dart'; // Importa la pantalla de inicio
import 'package:firebase_auth/firebase_auth.dart'; // Importar Firebase Auth

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controladores para los campos de texto
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Image.asset(
                          'lib/assets/images/icon.png', // Ruta de la imagen
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController, // Usando controlador
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController, // Usando controlador
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.visibility_off),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      String correo = emailController.text;
                      String password = passwordController.text;

                      try {
                        // Llama a la función de autenticación
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: correo,
                          password: password,
                        );

                        // Redirige al usuario a la pantalla principal si las credenciales son válidas
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } catch (e) {
                        // Muestra un mensaje de error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Error de inicio de sesión: $e')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text('Iniciar sesión con Email'),
                  ),
                  SizedBox(height: 20),
                  Text('¿Olvidó su contraseña?',
                      style: TextStyle(color: Colors.purple)),
                  SizedBox(height: 20),
                  Divider(thickness: 1, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('o Continuar con'),
                  SizedBox(height: 10),
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
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistroScreen()), // Navega a la pantalla de registro
                              );
                            },
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
