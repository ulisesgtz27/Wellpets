import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> registrarUsuario(
    String nombre, String telefono, String correo, String password) async {
  try {
    // Registro de usuario con Firebase Auth
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: correo, password: password);

    // Guardar información adicional del usuario en Firestore
    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userCredential.user!.uid)
        .set({
      'nombre': nombre,
      'telefono': telefono,
      'correo': correo,
      'password':
          password, // Considera si almacenar el password o no, es opcional.
    });

    print('Usuario registrado correctamente en Firestore');
    return true;
  } catch (e) {
    print('Error al registrar usuario en Firebase: $e');
    return false;
  }
}

Future<bool> autenticarUsuario(String correo, String password) async {
  try {
    // Inicio de sesión con Firebase Auth
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: correo, password: password);
    print('Usuario autenticado correctamente');
    return true;
  } catch (e) {
    print('Error de autenticación: $e');
    return false;
  }
}
