// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUsuario(Map<String, dynamic> usuarioData) async {
    final usuarioDocRef = _db.collection('usuarios').doc();
    await usuarioDocRef.set(usuarioData);
  }

  Future<void> addMascota(
      String userId, Map<String, dynamic> mascotaData) async {
    final mascotaDocRef =
        _db.collection('usuarios').doc(userId).collection('mascotas').doc();
    await mascotaDocRef.set(mascotaData);
  }

  Future<void> addRecordatorio(String userId, String mascotaId,
      Map<String, dynamic> recordatorioData) async {
    final recordatorioDocRef = _db
        .collection('usuarios')
        .doc(userId)
        .collection('mascotas')
        .doc(mascotaId)
        .collection('recordatorios')
        .doc();
    await recordatorioDocRef.set(recordatorioData);
  }
}
