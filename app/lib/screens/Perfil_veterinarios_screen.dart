import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wellpets/services/firestore_service.dart';
import 'package:wellpets/screens/inicio_sesion_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ),
      home: const PerfilUsuario(),
    );
  }
}

class PerfilUsuario extends StatefulWidget {
  const PerfilUsuario({super.key});

  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  File? _image;
  String _nombre = '';
  String _correo = '';
  String _fotoUrl = 'assets/images/perfil.png';

  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> _getUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      Map<String, dynamic> userData =
          await _firestoreService.getUserData(user.uid);
      setState(() {
        _nombre =
            userData['nombre'] ?? user.displayName ?? 'Nombre no disponible';
        _correo = userData['correo'] ?? user.email ?? 'Correo no disponible';
      });

      // Cargar la foto desde SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedPhoto = prefs.getString('profile_photo');
      if (savedPhoto != null) {
        setState(() {
          _fotoUrl = savedPhoto;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _fotoUrl = _image!.path; // Asignar la ruta local de la imagen
      });

      // Guardar la imagen seleccionada en SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_photo', _fotoUrl);
    }
  }

  // Método para cerrar sesión
  Future<void> _cerrarSesion() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const LoginScreen()), // Navegar a la pantalla de inicio de sesión
    );
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _fotoUrl.startsWith('assets')
                        ? AssetImage(_fotoUrl)
                        : FileImage(File(_fotoUrl)) as ImageProvider,
                    child: _image == null && _fotoUrl.startsWith('assets')
                        ? const Icon(Icons.camera_alt,
                            color: Colors.white, size: 30)
                        : null,
                  ),
                ),

                const SizedBox(height: 16),
                Text(
                  'Nombre de usuario',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  _nombre,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.grey,
                  height: 24,
                ),
                Column(
                  children: [
                    Text(
                      'Correo electrónico',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      _correo,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 24,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Acción al pulsar el botón de editar
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Editar Perfil',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 16),
                // Botón para cerrar sesión
                ElevatedButton(
                  onPressed: _cerrarSesion,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Cerrar Sesión',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
