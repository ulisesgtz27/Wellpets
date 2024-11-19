import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'registro_screen.dart'; // Importa la pantalla de registro
import 'home_screen.dart'; // Importa la pantalla de inicio
import 'package:wellpets/services/firestore_service.dart'; // Importa tu clase FirestoreService
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  final FirestoreService _firestoreService =
      FirestoreService(); // Instancia del servicio

  // Función para restablecer la contraseña
  Future<void> _resetPassword() async {
    String email = emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor ingrese su correo electrónico')),
      );
      return;
    }

    try {
      await _firestoreService
          .resetPassword(email); // Usamos la función de FirestoreService
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Se ha enviado un correo para restablecer la contraseña')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al enviar el correo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      String correo = emailController.text;
                      String password = passwordController.text;

                      if (correo.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Por favor ingrese todos los campos')),
                        );
                        return;
                      }

                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: correo,
                          password: password,
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } catch (e) {
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
                  TextButton(
                    onPressed: () {
                      // Mostrar cuadro de diálogo para restablecer la contraseña
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Restablecer contraseña'),
                            content: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Correo electrónico',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context); // Cierra el cuadro de diálogo
                                },
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  _resetPassword(); // Llamar a la función para enviar el correo
                                  Navigator.pop(
                                      context); // Cierra el cuadro de diálogo
                                },
                                child: Text('Enviar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      '¿Olvidó su contraseña?',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 1, color: Colors.grey),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
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
                                    builder: (context) => RegistroScreen()),
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
