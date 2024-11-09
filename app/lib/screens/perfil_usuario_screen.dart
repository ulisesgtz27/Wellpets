import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Para manejar archivos de imágenes
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wellpets/services/firestore_service.dart'; // Asegúrate de importar el servicio

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
      ),
      home: const perfilUsuario(),
    );
  }
}

class perfilUsuario extends StatefulWidget {
  const perfilUsuario({super.key});

  @override
  _perfilUsuarioState createState() => _perfilUsuarioState();
}

class _perfilUsuarioState extends State<perfilUsuario> {
  File? _image;
  String _nombre = '';
  String _correo = '';
  String _fotoUrl =
      'assets/images/perfil.png'; // Ruta local de la imagen predeterminada

  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService =
      FirestoreService(); // Instanciamos el servicio de Firestore
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Función para obtener los datos del usuario desde Firestore
  Future<void> _getUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Recuperar los datos de Firestore
      Map<String, dynamic> userData =
          await _firestoreService.getUserData(user.uid);
      setState(() {
        _nombre =
            userData['nombre'] ?? user.displayName ?? 'Nombre no disponible';
        _correo = userData['correo'] ?? user.email ?? 'Correo no disponible';
        // Si hay una foto en Firestore, la usamos, sino usamos la imagen local
        _fotoUrl = userData['photoUrl'] ??
            'assets/images/perfil.png'; // Imagen predeterminada local
      });
    }
  }

  // Función para seleccionar una imagen y actualizarla
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Subir la imagen a Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('profile_pictures').child(fileName);

      // Subir el archivo
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask;

      // Obtener la URL de la imagen subida
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Actualizar la URL de la imagen en Firestore y en el perfil de Firebase Authentication
      await _firestoreService.updateUserData(
        _auth.currentUser!.uid,
        {'photoUrl': imageUrl},
      );

      // También actualizamos el perfil en Firebase Authentication
      await _auth.currentUser!.updatePhotoURL(imageUrl);

      setState(() {
        _fotoUrl = imageUrl;
      });
    }
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage, // Llama a la función al tocar la imagen
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _fotoUrl.startsWith('assets')
                    ? AssetImage(
                        _fotoUrl) // Si es una ruta local, usaremos AssetImage
                    : NetworkImage(_fotoUrl) as ImageProvider,
                child: _image == null
                    ? const Icon(Icons.camera_alt, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _correo,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Acción al pulsar el botón de editar (esto lo puedes personalizar más)
              },
              child: const Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
