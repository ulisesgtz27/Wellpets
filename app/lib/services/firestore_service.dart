import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Método para obtener los datos del usuario desde Firestore
  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _db.collection('usuarios').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        return {}; // Si el documento no existe, devuelve un mapa vacío
      }
    } catch (e) {
      print('Error obteniendo datos del usuario: $e');
      return {}; // En caso de error, también devuelve un mapa vacío
    }
  }

  // Método para actualizar los datos del usuario en Firestore
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('usuarios').doc(uid).update(data);
    } catch (e) {
      print('Error actualizando datos del usuario: $e');
    }
  }

  // Método para agregar un nuevo usuario (si no existe en Firestore)
  Future<void> addUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('usuarios').doc(uid).set(data);
    } catch (e) {
      print('Error agregando datos del usuario: $e');
    }
  }

  // Método para guardar una mascota en Firestore
  Future<void> addMascota(String uid, Map<String, dynamic> mascotaData) async {
    try {
      await _db.collection('mascotas').doc(uid).set(mascotaData);
    } catch (e) {
      print('Error agregando mascota: $e');
    }
  }

  // Método para obtener las mascotas de un usuario
  Future<List<Map<String, dynamic>>> getMascotasByUserId(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('usuarios')
          .doc(userId)
          .collection('mascotas')
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((doc) => doc.data()) // Elimina el cast innecesario
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error obteniendo mascotas: $e");
      return [];
    }
  }

  // Método para obtener los datos de una mascota específica usando su ID
  Future<Map<String, dynamic>> getMascotaData(
      String userId, String mascotaId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('usuarios')
          .doc(userId)
          .collection('mascotas')
          .doc(mascotaId)
          .get();

      if (snapshot.exists) {
        return snapshot.data()!;
      } else {
        return {}; // Devuelve un Map vacío si el documento no existe
      }
    } catch (e) {
      print("Error fetching mascota data: $e");
      return {}; // Devuelve un Map vacío en caso de error
    }
  }
}
